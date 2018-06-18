Shader "AW_Standard" {
	Properties {
	    _Color ("Color", Color) = (0, 0, 0, 1)
	    _SoundPos ("Sounded Pos", Vector) = (0, 0, 0, 1.0)
	    _Distance ("SoundDistance", float) = 0
	    _RetainTime ("RetainTime", float) = 3
	    [Toggle]_isRipple ("isRipple", float) = 0
	}
	SubShader {
	    Tags { "Queue" = "Transparent" }
	    
	    Pass
	    {
	        CGPROGRAM
	        
	        #pragma vertex vert
	        #pragma fragment frag
	        #include "UnityCG.cginc"
	        
	        uniform float4 _Color;
	        
	        uniform float4 _SoundPos;
	        uniform float _Distance;
	        uniform float _isRipple;
	        uniform float _RetainTime;
	        
	        struct appdata
	        {
	            float4 vertex : POSITION;
	            float2 uv : TEXCOORD0;
	        };
	        
	        struct v2f
	        {
	            float4 vertex : SV_POSITION;
	            float2 uv : TEXCOORD0;
	        };
	        
	        v2f vert(appdata i)
	        {
	            v2f o;
	            
	            o.vertex = UnityObjectToClipPos(i.vertex);
	            o.uv = mul(unity_ObjectToWorld, i.vertex);
	            
	            return o;
	            
	        }
	        
	        float4 frag(v2f i) : COLOR
	        {
	            float dist = distance(i.uv, _SoundPos);
	            
	            if(dist < _Distance && _isRipple)
	                    return _Color;
	            else
	            {
	                return float4(0, 0, 0, 1.0);
	            }
	        }
	        
	        ENDCG
	        
	        
	    }
	}
	FallBack "Diffuse"
}
