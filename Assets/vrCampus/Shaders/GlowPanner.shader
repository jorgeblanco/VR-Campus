// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SwordBlade"
{
	Properties
	{
		_Panner("Panner", 2D) = "white" {}
		_PanSpeed("PanSpeed", Float) = 1
		[HDR]_EmmisionColor("EmmisionColor", Color) = (0.2544555,0.5663687,0.7838871,1)
		_Intensity("Intensity", Range( 0 , 3)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform half4 _EmmisionColor;
		uniform sampler2D _Panner;
		uniform float _PanSpeed;
		uniform float _Intensity;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 temp_cast_0 = (( _Time.y * -1.0 * _PanSpeed )).xx;
			float2 uv_TexCoord4 = i.uv_texcoord * float2( 1,1 ) + temp_cast_0;
			o.Emission = ( ( _EmmisionColor + tex2D( _Panner, uv_TexCoord4 ) ) * _Intensity ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=14301
-1438;62;1416;925;1555.052;698.0286;1.601348;True;True
Node;AmplifyShaderEditor.RangedFloatNode;12;-1104.867,116.2088;Float;False;Property;_PanSpeed;PanSpeed;1;0;Create;True;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;8;-1155.783,-104.9391;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-882.7856,-64.21696;Float;False;3;3;0;FLOAT;0.0;False;1;FLOAT;-1.0;False;2;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;4;-866.6552,-268.3352;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-618.2831,-217.2694;Float;True;Property;_Panner;Panner;0;0;Create;True;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;13;-603.9968,133.4116;Half;False;Property;_EmmisionColor;EmmisionColor;2;1;[HDR];Create;True;0.2544555,0.5663687,0.7838871,1;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;23;-640.6824,389.2868;Float;False;Property;_Intensity;Intensity;3;0;Create;True;0;0;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;21;-253.1565,-22.2597;Float;False;2;2;0;COLOR;0.0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-99.42702,-22.25967;Float;False;2;2;0;COLOR;0.0;False;1;FLOAT;0.0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;167,-243;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;SwordBlade;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;False;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;2;15;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;11;0;8;2
WireConnection;11;2;12;0
WireConnection;4;1;11;0
WireConnection;2;1;4;0
WireConnection;21;0;13;0
WireConnection;21;1;2;0
WireConnection;19;0;21;0
WireConnection;19;1;23;0
WireConnection;0;2;19;0
ASEEND*/
//CHKSM=FE0FBE13AD59259610107F9FE14212F2EC5B9923