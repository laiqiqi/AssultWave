// Upgrade NOTE: upgraded instancing buffer 'Props' to new syntax.

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "AW_Standard" {
	Properties {
	    _MainTex ("Albedo(RGB)", 2D) = "white" {}
	    _Color ("Color", Color) = (0, 0, 0, 1)
	    _EdgeColor ("EdgeColor", Color) = (1, 1, 1, 1)
	    _Darkness ("Darkness", Range(0,1)) = 0
	    _SoundPos ("Sounded Pos", Vector) = (0, 0, 0, 0.0)
	    _Distance ("SoundDistance", float) = 0
	    _RetainTime ("RetainTime", float) = 1
	    [Toggle]_isRipple ("isRipple", float) = 0
	    _EdgeWidth ("Edge Width", Range(0.01, 1)) = 0.2
	}
	SubShader {
	    Tags { "RenderType" = "Opaque" }
            
        Pass{
	        LOD 200
	        CGPROGRAM
	        
	        #pragma vertex vert
	        #pragma fragment frag
	        #include "UnityCG.cginc"
	        
	        #pragma target 3.0
	        
	        uniform sampler2D _MainTex;
	        uniform float _Darkness;
	        uniform fixed4 _Color;
	        uniform fixed4 _EdgeColor;
	        uniform float _EdgeWidth;
	        
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
	            float3 worldpos : TEXCOORD1;
	        };
	        
	        float4 DarkColor(float4 color)
	        {
	            float4 final = color-(color*_Darkness);
	            
	            return final;
	        }
	        
	        float Time()
	        {
	            return _isRipple ? _Time.y/_RetainTime*0.8 : 1;
	        }
	        
	        v2f vert(appdata i)
	        {
	            v2f o;
	            
	            o.vertex = UnityObjectToClipPos(i.vertex);
	            float3 worldpos = mul(unity_ObjectToWorld, i.vertex).xyz;
	            
	            o.worldpos=worldpos;
	            o.uv=i.uv.xy;
	            
	            return o;
	            
	        }
	        
	        float4 frag(v2f i) : COLOR
	        {
	            float4 color = DarkColor(tex2D(_MainTex, i.uv)*_Color);
	            float dist = distance(i.worldpos,_SoundPos);
	            float distance_Time = _Distance;
	            float4 black = float4(0, 0, 0, 1);
	            float4 fcolor=float4(1,1,1,1);
	            
	            if(_isRipple)
	            {
	                //if(dist <= (_Distance - distance_Time) + _EdgeWidth / 2 && dist >= (_Distance - distance_Time) - _EdgeWidth / 2)
	                if(dist <= (_Distance*Time()-_Distance) + _EdgeWidth / 2 && dist >= (_Distance*Time()-_Distance) - _EdgeWidth / 2)
	                {
	                    if(distance_Time<=_Distance)
	                    {
	                        //distance_Time += _Distance / 1 * Time();
	                    }
	                    
	                    //fcolor.r -= color.r/1*Time();
	                    //fcolor.g -= color.g/1*Time();
	                    //fcolor.b -= color.b/1*Time();
	                    return float4(1,1,1,1);
	                }
	                else
	                {
	                    return float4(0,0,0,1);
	                }
	            }
	            else
	            {
	                return float4(0,0,0,1);
	            }
	            
	        }
	        
	        ENDCG
	        
	    }
	    
	}
	FallBack "Diffuse"
}
