################################################################################
#
# Copyright (c) 2010 The MadGraph5_aMC@NLO Development team and Contributors
#
# This file is a part of the MadGraph5_aMC@NLO project, an application which 
# automatically generates Feynman diagrams and matrix elements for arbitrary
# high-energy processes in the Standard Model and beyond.
#
# It is subject to the MadGraph5_aMC@NLO license which should accompany this 
# distribution.
#
# For more information, visit madgraph.phys.ucl.ac.be and amcatnlo.web.cern.ch
#
################################################################################
"""Module to allow reading a param_card and setting all parameters and
couplings for a model"""

from __future__ import division

from __future__ import absolute_import
import array
import cmath
import copy
import itertools
import logging
import math
import os
import re
import aloha

import madgraph.core.base_objects as base_objects
import madgraph.loop.loop_base_objects as loop_base_objects
import models.check_param_card as card_reader
from madgraph import MadGraph5Error, MG5DIR
import madgraph.various.misc as misc
import six

ZERO = 0

#===============================================================================
# Logger for model_reader
#===============================================================================

logger = logging.getLogger('madgraph.models')

#===============================================================================
# ModelReader: Used to read a param_card and calculate parameters and
#              couplings of the model.
#===============================================================================
class ModelReader(loop_base_objects.LoopModel):
    """Object to read all parameters and couplings of a model
    """

    def default_setup(self):
        """The particles is changed to ParticleList"""
        self['coupling_dict'] = {}
        self['parameter_dict'] = {}
        super(ModelReader, self).default_setup()

    def set_parameters_and_couplings(self, param_card = None, scale=None,
                                                      complex_mass_scheme=None,
                                                      auto_width=None):
        """Read a param_card and calculate all parameters and
        couplings. Set values directly in the parameters and
        couplings, plus add new dictionary coupling_dict from
        parameter name to value."""

        all_params = {}

        param_card_text = None
        # Extract external parameters
        external_parameters = self['parameters'][('external',)]
        # Read in param_card
        if param_card:
            # Create a dictionary from LHA block name and code to parameter name
            parameter_dict = {}
            for param in external_parameters:
                try:
                    dictionary = parameter_dict[param.lhablock.lower()]
                except KeyError:
                    dictionary = {}
                    parameter_dict[param.lhablock.lower()] = dictionary
                dictionary[tuple(param.lhacode)] = param
            if isinstance(param_card, six.string_types):
                # Check that param_card exists
                if not os.path.isfile(param_card):
                    raise MadGraph5Error("No such file %s" % param_card)
                param_card_text = param_card
                param_card = card_reader.ParamCard(param_card)
                if 'decay' in param_card:
                    for param in param_card.get('decay'):
                        if str(param.value).lower() == 'auto':
                            param.value = auto_width(param_card, param.lhacode)
            #misc.sprint(type(param_card), card_reader.ParamCard,  isinstance(param_card, card_reader.ParamCard))
            #assert isinstance(param_card, card_reader.ParamCard),'%s is not a ParamCard: %s' % (type(param_card),  isinstance(param_card, card_reader.ParamCard))    
            
            if complex_mass_scheme is None:
                if aloha.complex_mass:
                    param_card.convert_to_complex_mass_scheme()
            else:
                if complex_mass_scheme:
                    param_card.convert_to_complex_mass_scheme()
    
            key = [k for k in param_card.keys() if not k.startswith('qnumbers ')
                                            and not k.startswith('decay_table')
                                            and 'info' not in k]
            param_key = [k for k in parameter_dict.keys() if 'info' not in k]
            
            if set(key) != set(parameter_dict.keys()):
                # the two card are different. check if this critical
                fail = True
                missing_set = set(parameter_dict.keys()).difference(set(key))
                unknow_set = set(key).difference(set(parameter_dict.keys()))
                missing_block = ','.join(missing_set)
                unknow_block = ','.join(unknow_set)
                
    
                msg = '''Invalid restriction card (not same block)
    %s != %s.
    Missing block: %s
    Unknown block : %s''' % (set(key), set(parameter_dict.keys()),
                             missing_block, unknow_block)
                apply_conversion = []
                
                if 'loop' in missing_set:
                    key.append('loop')
                    fail =  False
                
                if not missing_block:
                    logger.warning("Unknow type of information in the card: %s" % unknow_block)
                    fail = False
                elif self['name'].startswith('mssm-') or self['name'] == 'mssm':
                    if not missing_set:
                        fail = False
                    else:
                        apply_conversion.append('to_slha2')
                        overwrite = False
                elif missing_set == set(['fralpha']) and 'alpha' in unknow_set:
                    apply_conversion.append('alpha')
                elif  self.need_slha2(missing_set, unknow_set):
                    apply_conversion.append('to_slha2')
                    overwrite = True
                    
                if apply_conversion:
                    try:
                        if 'to_slha2' in apply_conversion:
                            if overwrite:
                                logger.error('Convention for the param_card seems to be wrong. Trying to automatically convert your file to SLHA2 format. \n'+\
                                 "Please check that the conversion occurs as expected (The converter is not fully general)")
                                import time
                                time.sleep(5)
                            
                            param_card = param_card.input_path
                            param_card = card_reader.convert_to_mg5card(param_card,
                                                                         writting=overwrite)
                            key = [k for k in param_card.keys() if not k.startswith('qnumbers ')
                                                    and not k.startswith('decay_table')]
                            if not set(parameter_dict.keys()).difference(set(key)):
                                fail = False
                        if 'alpha' in apply_conversion:
                            logger.info("Missing block fralpha but found a block alpha, apply automatic conversion")
                            param_card.rename_blocks({'alpha':'fralpha'})
                            param_card['fralpha'].rename_keys({(): (1,)})
                            param_card.write(param_card.input_path)
                            key = [k for k in param_card.keys() if not k.startswith('qnumbers ')
                                                    and not k.startswith('decay_table')]
                            if not set(parameter_dict.keys()).difference(set(key)):
                                fail = False
                    except Exception:
                        raise
                        raise MadGraph5Error(msg)
                        
                
                if fail:
                    raise MadGraph5Error(msg)

            for block in key:
                if block not in parameter_dict:
                    continue
                for pid in parameter_dict[block]:
                    try:
                        value = param_card[block].get(pid).value
                    except:
                        if block == 'loop':
                            value = param_card['mass'].get(23).value
                        else:
                            raise MadGraph5Error('%s %s not define' % (block, pid))

                    if isinstance(value, str) and value.lower() == 'auto':
                        value = '0.0' 
                    if scale and parameter_dict[block][pid].name == 'aS':
                        runner = Alphas_Runner(value, nloop=2)
                        try:
                            value = runner(scale)
                        except ValueError as err:
                            if str(err) == 'math domain error' and scale < 1:
                                value = 0.0
                            else:
                                raise
                        except OverflowError as err:
                            if scale < 1:
                                value = 0.0
                            else:
                                raise
                            
                    exec("locals()[\'%s\'] = %s" % (parameter_dict[block][pid].name,
                                          value), all_params)
                    parameter_dict[block][pid].value = float(value)
           
        else:
            # No param_card, use default values
            for param in external_parameters:
                if scale and parameter_dict[block][id].name == 'aS':
                    runner = Alphas_Runner(value, nloop=3)
                    value = runner(scale)
                exec("locals()[\'%s\'] = %s" % (param.name, param.value), globals(), all_params)
            
        # Define all functions used
        for func in self['functions']:
            exec("def %s(%s):\n   return %s" % (func.name,
                                                ",".join(func.arguments),
                                                func.expr), globals(), all_params)

        # Extract derived parameters
        derived_parameters = []
        keys = [key for key in self['parameters'].keys() if \
                key != ('external',)]
        keys.sort(key=len)
        for key in keys:
            derived_parameters += self['parameters'][key]	

        # Now calculate derived parameters
        for param in derived_parameters:
            try:
                exec("locals()[\'%s\'] = %s" % (param.name, param.expr), globals(), all_params)
            except Exception as error:
                msg = 'Unable to evaluate %s = %s: raise error: %s' % (param.name,param.expr, error)
                raise MadGraph5Error(msg)
            param.value = complex(all_params[param.name])
            if not all_params[param.name] and all_params[param.name] != 0:
                logger.warning("%s has no expression: %s" % (param.name,
                                                             param.expr))

        # Correct width sign for Majorana particles (where the width
        # and mass need to have the same sign)
        for particle in self.get('particles'):
            if particle.is_fermion() and particle.get('self_antipart') and \
                   particle.get('width').lower() != 'zero' and \
                   eval(particle.get('mass'), globals(), all_params).real < 0:
                exec("locals()[\'%(width)s\'] = -abs(%(width)s)" % \
                     {'width': particle.get('width')}, globals(), all_params)

        # Extract couplings
        couplings = sum(list(self['couplings'].values()), [])
        # Now calculate all couplings
        for coup in couplings:
            #print "I execute %s = %s"%(coup.name, coup.expr)
            exec("locals()[\'%s\'] = %s" % (coup.name, coup.expr), globals(), all_params)
            coup.value = complex(all_params[coup.name])
            if not all_params[coup.name] and all_params[coup.name] != 0:
                logger.warning("%s has no expression: %s" % (coup.name,
                                                             coup.expr))

        # Set parameter and coupling dictionaries
        self.set('parameter_dict', dict([(param.name, param.value) \
                                        for param in external_parameters + \
                                         derived_parameters]))

        # Add "zero"
        self.get('parameter_dict')['ZERO'] = complex(0.)

        self.set('coupling_dict', dict([(coup.name, coup.value) \
                                        for coup in couplings]))
        
        return all_params
    
    def get_mass(self, pdg_code):
        """easy way to have access to a mass value"""
        
        if isinstance(pdg_code, (int,str)):
            return self.get('parameter_dict')[self.get_particle(pdg_code).get('mass')].real
        else:
            return self.get('parameter_dict')[pdg_code.get('mass')].real
            
    def get_width(self, pdg_code):
        """easy way to have access to a width value"""
        if isinstance(pdg_code, (int,str)):
            return self.get('parameter_dict')[self.get_particle(pdg_code).get('width')].real
        else:
            return self.get('parameter_dict')[pdg_code.get('mass')].real
    
    def need_slha2(self, missing_set, unknow_set):
    
        return all([b in missing_set for b in ['te','msl2','dsqmix','tu','selmix','msu2','msq2','usqmix','td', 'mse2','msd2']]) and\
                     all(b in unknow_set for b in ['ae','ad','sbotmix','au','modsel','staumix','stopmix'])
    
class Alphas_Runner(object):
    """Evaluation of strong coupling constant alpha_S"""
    #     Author: Olivier Mattelaer translated from a fortran routine 
    #     written by R. K. Ellis
    #
    #     q -- scale at which alpha_s is to be evaluated
    #
    #     asmz -- value of alpha_s at the mass of the Z-boson
    #     nloop -- the number of loops (1,2, or 3) at which beta 
    #
    #     function is evaluated to determine running.
    #     the values of the cmass and the bmass should be set
    #---------------------------------------------------------------------------    
    
    def __init__(self, asmz, nloop, zmass=91.188, cmass=1.4, bmass=4.7):
    
        self.asmz = asmz
        self.nloop = nloop
        self.zmass = zmass
        self.cmass = cmass
        self.bmass = bmass
    
        assert asmz > 0
        assert cmass > 0
        assert bmass > 0
        assert nloop > -1
        t = 2 * math.log(bmass/zmass)
        self.amb = self.newton1(t, asmz, 5)
        t = 2 * math.log(cmass/bmass)
        self.amc = self.newton1(t, self.amb, 4)    
    
    def __call__(self, scale):
        """Evaluation of strong coupling constant alpha_S at scale 'scale'."""
        assert scale > 0
        
        
        if scale < 0.188775276209:
            return 0
        elif scale < self.cmass:
            t = 2 * math.log(scale/self.cmass)
            return self.newton1(t, self.amc, 3)
        elif scale < self.bmass:
            t = 2 * math.log(scale/self.bmass)
            return self.newton1(t, self.amb, 4)
        else:
            t = 2 * math.log(scale/self.zmass)
            return self.newton1(t, self.asmz, 5)

    # B0=(11.-2.*NF/3.)/4./PI
    b0 = [0.716197243913527, 0.66314559621623, 0.61009394851893]
    # C1=(102.D0-38.D0/3.D0*NF)/4.D0/PI/(11.D0-2.D0/3.D0*NF)
    c1 = [0.565884242104515, 0.49019722472304, 0.40134724779695]
    # C2=(2857.D0/2.D0-5033*NF/18.D0+325*NF**2/54)/16.D0/PI**2/(11.D0-2.D0/3.D0*NF)
    c2 = [0.453013579178645, 0.30879037953664, 0.14942733137107]
    # DEL=SQRT(4*C2-C1**2)
    d = [1.22140465909230, 0.99743079911360, 0.66077962451190]


    
    def newton1(self, t, alphas, nf):
        """calculate a_out using nloop beta-function evolution 
        with nf flavours, given starting value as-in
        given alphas and logarithmic separation between 
        input scale and output scale t.
        Evolution is performed using Newton's method,
        with a precision given by tol."""        
        nloop = self.nloop
        tol = 5e-4
        arg = nf-3
        b0, c1, c2, d = self.b0[arg], self.c1[arg], self.c2[arg], self.d[arg] 

        if nloop == 2:
            f = lambda AS: 1.0/AS+c1*math.log((c1*AS)/(1+c1*AS))
        elif nloop == 3:
            f = lambda AS: 1.0/AS+0.5*c1*math.log((c2*AS**2)/(1+c1*AS+c2*AS**2)) \
                 -(c1**2-2*c2)/d*math.atan((2*c2*AS+c1)/d)
        
        a_out = alphas / (1 + alphas * b0 * t)
        if nloop == 1:
            return a_out

        a_out = alphas/(1+b0*alphas*t+c1*alphas*math.log(1+alphas*b0*t))
        if a_out < 0:
            a_out = 0.3
        
        while 1:
            AS = a_out
            F = b0 * t + f(alphas) -f(AS)
            if nloop == 2:
                FP=1/(AS**2*(1+c1*AS))
            elif nloop == 3:
                FP=1/(AS**2*(1+c1*AS + c2 * AS**2))
            if FP == 0:
               return AS
            a_out = AS - F/FP
            delta = abs(F/FP/AS)
            if delta < tol:
                break
        return a_out
            



