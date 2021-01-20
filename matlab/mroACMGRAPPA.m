classdef mroACMGRAPPA<mroACM
    
    properties
        
        
    end
    
    methods
        
        
        %constructor
        function this=mroACMGRAPPA(s,n,js)
            %the class expects a 3D matrix composed by a tile of 2D kspaces (fxpxncoils) of a signal and a
            %noise.
            
            this.setImageReconstructor(cm2DReconGRAPPA());
            
            if nargin>0
                this.setSignalKSpace(s);
            end
            
            if nargin>1
                this.setNoiseKSpace(n);
            end
            
            if nargin>1
                this.setConf(js);
            end
            
        end
        function setConf(this,js)
            
            this.Config.Type=js.Type;
            
            this.Config.FlipAngleMap=js.FlipAngleMap;
            
            try;this.Config.NoiseFileType=js.NoiseFileType;end
            try;this.Config.NBW=js.NBW;end;
            
            
            R=this.getImageReconstructor();
            
            this.Config.AccelerationF = js.AccelerationF;
            this.Config.AccelerationP = js.AccelerationP;
            this.Config.AutocalibrationF = js.AutocalibrationF;
            this.Config.AutocalibrationP = js.AutocalibrationP;
            
            this.Config.GrappaKernel1 = js.GrappaKernel1;
            this.Config.GrappaKernel2 = js.GrappaKernel2;
            
            R.setAccelerationFrequency(js.AccelerationF);
            R.setAccelerationPhase(js.AccelerationP);
            R.setAutocalibrationFrequency(js.AutocalibrationF);
            R.setAutocalibrationPhase(js.AutocalibrationP);
            R.setGrappaKernel([js.GrappaKernel1 js.GrappaKernel2]);
            
            R.setSosRecon(js.SoSRecon);
            
            
            
        end
        
        function O=getParams(this)
            
            O.Type=this.Config.Type;
            O.FlipAngleMap=this.Config.FlipAngleMap;
            O.NoiseFileType=this.Config.NoiseFileType;
            O.NBW=this.Config.NBW;
            
        
            
            
            O.AccelerationF = this.Config.AccelerationF;
            O.AccelerationP = this.Config.AccelerationP;
            
            O.GFactorMask =this.GFactorMaskID;
            O.AutocalibrationF=this.Config.AutocalibrationF;
            O.AutocalibrationP=this.Config.AutocalibrationP;
            
             O.GrappaKernel1=this.Config.GrappaKernel1;
             O.GrappaKernel2=this.Config.GrappaKernel2;
            
             O.SoSRecon=this.Config.SoSRecon;
        end
        
        
        function O=undersampleTheSignal(this,R,K)
            %different for sense and grappa a reconstructor must be passed
            O=R.mimicmGrappaDataFromFullysampledZeroPadded(K,R.getAccelerationFrequency(),R.getAccelerationPhase(),R.getAutocalibrationFrequency(),R.getAutocalibrationPhase());
        end
        
        
        %ovverride since no implementation given
        function o=getSNR(this)
                    S=this.getSignalKSpace();
                  o=NaN(size(S,1),size(S,2));
         end
        
        
    end
end

