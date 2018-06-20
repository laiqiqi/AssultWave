// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "AW_Standard" {
	Properties {
	    _MainTex ("Albedo(RGB)", 2D) = "white" {}
	    _Color ("Color", Color) = (0, 0, 0, 1)
	    _Darkness ("Darkness", Range(0,1)) = 0
	    _SoundPos ("Sounded Pos", Vector) = (0, 0, 0, 0.0)
	    _Distance ("SoundDistance", float) = 0
	    _RetainTime ("RetainTime", float) = 1
	    [Toggle]_isRipple ("isRipple", float) = 0
	}
	SubShader {
	    Tags { "Queue" = "Opaque" }
	    
	    Pass //버텍스,프래그먼트
	    {
	        LOD 200
	        CGPROGRAM
	        
	        #pragma vertex vert
	        #pragma fragment frag
	        #include "UnityCG.cginc"
	        
	        #pragma target 4.0
	        
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
	            float3 worldpos : TEXCOORD1;
	        };
	        
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
	            float dist = distance(i.worldpos,_SoundPos);
	            float4 black = float4(0, 0, 0, 1);
	            if(_isRipple)
	            {
	                if(dist<=_Distance)
	                {
	                    return _Color;
	                }
	                else
	                {
	                    return black;
	                }
	            }
	            else
	            {
	                return black;
	            }
	            
	        }
	        
	        ENDCG
	        
	    }
	    /*
	    Pass //서페이스 쉐이더
	    {
	        LOD 200
	        CGPROGRAM
	        #pragma surface surf Standard
	        
	        #pragma target 4.0
	        uniform sampler2D _MainTex;
	        
	        uniform float _Darkness;
	        uniform float _isRipple;
	        
	        struct Input
	        {
	            float2 uv_MainTex;
	        };
	        
	        void surf (Input IN, inout SurfaceOutputStandard o)
	        {
	            fixed4 c = tex2D(_MainTex, IN.uv_MainTex)+(_Darkness-_isRipple);
	            
	            o.Albedo = c.rgb;
	            o.Alpha = c.a;
	        }
	        
	        ENDCG
	    }*/
	    
	}
	FallBack "Diffuse"
}
