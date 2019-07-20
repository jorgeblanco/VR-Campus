// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ScanlineNoise"
{
	Properties
	{
		_Pattern("Pattern", 2D) = "white" {}
		_panspeed("pan speed", Range( -8 , 8)) = 1
		_noise("noise", 2D) = "white" {}
		[HDR]_ColorOff("ColorOff", Color) = (0,0.5840786,1,1)
		[HDR]_ColorOn("ColorOn", Color) = (0,0.7887945,1,0)
		_screenGlow("screenGlow", 2D) = "white" {}
		_Hover("Hover", Range( 0 , 1)) = 0
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
			float3 worldPos;
		};

		uniform sampler2D _Pattern;
		uniform float _panspeed;
		uniform sampler2D _noise;
		uniform sampler2D _screenGlow;
		uniform float4 _screenGlow_ST;
		uniform float4 _ColorOff;
		uniform float4 _ColorOn;
		uniform float _Hover;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Albedo = float4(0,0,0,0).rgb;
			float wpMod = (i.worldPos.y  % 1.0);
			float s = sign(wpMod-0.5);
			float2 uv_mod = i.uv_texcoord;
			uv_mod.y += wpMod;
			float2 temp_cast_1 = (( _Time.x  * _panspeed * s)).xx;
			float2 uv_TexCoord11 = uv_mod * float2( 1.0,0.34 ) + temp_cast_1;
			float2 temp_cast_2 = (( ( 4.0 * 1.0 ) * 1.0 * _Time.w  )).xx;
			float2 uv_TexCoord20 = i.uv_texcoord * float2( 1,1 ) + temp_cast_2;
			float2 uv_screenGlow = i.uv_texcoord * _screenGlow_ST.xy + _screenGlow_ST.zw;
			float4 lerpResult33 = lerp( _ColorOff , _ColorOn , _Hover);
			o.Emission = ( ( ( ( float4(0.05660379,0.05660379,0.05660379,0) + ( tex2D( _Pattern, uv_TexCoord11 ).a * float4(0.2075472,0.2075472,0.2075472,0) ) ) + ( tex2D( _noise, uv_TexCoord20 ) * float4( 0.3113208,0.3113208,0.3113208,0 ) ) ) + tex2D( _screenGlow, uv_screenGlow ) ) * lerpResult33 ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=14301
-1438;62;1416;925;1045.987;537.4158;1.665504;True;True
Node;AmplifyShaderEditor.TimeNode;6;-1357.826,-108.7712;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;14;-1418.234,48.13043;Float;False;Property;_panspeed;pan speed;1;0;Create;True;1;0;-8;8;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;12;-1292.073,-315.7333;Float;False;Constant;_Vector0;Vector 0;1;0;Create;True;1,0.34;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;-1287.706,-671.0699;Float;False;2;2;0;FLOAT;4.0;False;1;FLOAT;1.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-1087.602,18.10349;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-1070.805,-652.6188;Float;False;3;3;0;FLOAT;0.0;False;1;FLOAT;1.0;False;2;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;11;-972.7379,-277.7193;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;5;-646.4352,10.91706;Float;False;Constant;_Color1;Color 1;1;0;Create;True;0.2075472,0.2075472,0.2075472,0;0.1177465,0.3350245,0.509434,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;20;-923.8133,-699.993;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-738.8361,-297.3793;Float;True;Property;_Pattern;Pattern;0;0;Create;True;01e01d3aa1fc1574c8091bb194f9872c;01e01d3aa1fc1574c8091bb194f9872c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;18;-617.2737,-773.335;Float;True;Property;_noise;noise;2;0;Create;True;d71639fc28eeef84fb3e85a3939e8903;d71639fc28eeef84fb3e85a3939e8903;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-435.6684,-201.2998;Float;False;2;2;0;FLOAT;0.0;False;1;COLOR;0.96;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;2;-693.765,-492.6927;Float;False;Constant;_Color0;Color 0;1;0;Create;True;0.05660379,0.05660379,0.05660379,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-223.2784,-550.1332;Float;False;2;2;0;COLOR;0.0;False;1;COLOR;0.3113208,0.3113208,0.3113208,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;3;-284.3458,-335.5522;Float;True;2;2;0;COLOR;0.0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;28;-75.59634,-8.688085;Float;False;Property;_ColorOn;ColorOn;4;1;[HDR];Create;True;0,0.7887945,1,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;31;-175.7043,-93.98257;Float;True;Property;_screenGlow;screenGlow;5;0;Create;True;4873c7e9b99b7cd409f88bdf219e3b97;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;17;-46.31406,-340.1224;Float;True;2;2;0;COLOR;0.0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-156.145,326.1513;Float;False;Property;_Hover;Hover;6;0;Create;True;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;34;-100.4435,151.9561;Float;False;Property;_ColorOff;ColorOff;3;1;[HDR];Create;True;0,0.5840786,1,1;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;33;340.3275,86.8586;Float;False;3;0;COLOR;0.0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;30;166.8271,-339.3146;Float;True;2;2;0;COLOR;0.0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;23;39.29832,-530.9348;Float;False;Constant;_Color2;Color 2;3;0;Create;True;0,0,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;380.0256,-333.4273;Float;True;2;2;0;COLOR;0.0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;599.0227,-412.1745;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;ScanlineNoise;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;False;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;2;15;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;OFF;OFF;0;False;8.76;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;15;0;6;1
WireConnection;15;1;14;0
WireConnection;21;0;22;0
WireConnection;21;2;6;4
WireConnection;11;0;12;0
WireConnection;11;1;15;0
WireConnection;20;1;21;0
WireConnection;1;1;11;0
WireConnection;18;1;20;0
WireConnection;4;0;1;4
WireConnection;4;1;5;0
WireConnection;19;0;18;0
WireConnection;3;0;2;0
WireConnection;3;1;4;0
WireConnection;17;0;3;0
WireConnection;17;1;19;0
WireConnection;33;0;34;0
WireConnection;33;1;28;0
WireConnection;33;2;35;0
WireConnection;30;0;17;0
WireConnection;30;1;31;0
WireConnection;24;0;30;0
WireConnection;24;1;33;0
WireConnection;0;0;23;0
WireConnection;0;2;24;0
ASEEND*/
//CHKSM=F0F18F335E2A71BD89380FDA9F37F2567DBCD55C