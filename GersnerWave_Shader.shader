// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "GerstnerWaves"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		[HideInInspector] _DummyTex( "", 2D ) = "white" {}
		_Amplitude("Amplitude", Float) = 11
		_SteepnessRange("Steepness Range", Range( 0 , 20)) = 59.59169
		_SteepnessFalloff("Steepness Falloff", Range( 0 , 1)) = 0.3684832
		_SteepnessCoeff("Steepness Coeff", Range( 0 , 20)) = 3
		_Wavelength("Wavelength", Float) = 1
		_Speed("Speed", Float) = 1
		_NumberOfWaves("Number Of Waves", Float) = 1
		_Steepness("Steepness", Float) = 1
		_WaveHeight("WaveHeight", 2D) = "white" {}
		_HeightCoeff("Height Coeff", Range( 0 , 10)) = 1
		_WaveNormals("WaveNormals", 2D) = "bump" {}
		_NormalMapScale("Normal Map Scale", Float) = 1
		_Tiling("Tiling", Float) = 1
		_ForcedSpecFresnel("Forced Spec Fresnel", Float) = 6
		_SpecColorNorm("Spec Color Norm", Color) = (1,1,1,1)
		_ForcedSpecIntensity("Forced Spec Intensity", Float) = 12
		_ForcedSpecGlossiness("Forced Spec Glossiness", Float) = 3
		_ForcedSpecColor("Forced Spec Color", Color) = (0.05147058,0.450507,1,1)
		_Smoothness("Smoothness", Range( 0 , 2)) = 0
		_TessMaxDistance("Tess Max Distance", Float) = 300
		_TessAmount("Tess Amount", Float) = 50
		_Albedo("Albedo", 2D) = "white" {}
		_GlossMap("Gloss Map", 2D) = "white" {}
		_TextureSample2("Texture Sample 2", 2D) = "white" {}
		_SpecMap("Spec Map", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#include "Tessellation.cginc"
		#pragma target 5.0
		#pragma surface surf StandardSpecular keepalpha vertex:vertexDataFunc tessellate:tessFunction 
		struct Input
		{
			float2 uv_DummyTex;
			float2 uv_texcoord;
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
		};

		struct appdata
		{
			float4 vertex : POSITION;
			float4 tangent : TANGENT;
			float3 normal : NORMAL;
			float4 texcoord : TEXCOORD0;
			float4 texcoord1 : TEXCOORD1;
			float4 texcoord2 : TEXCOORD2;
			float4 texcoord3 : TEXCOORD3;
			fixed4 color : COLOR;
			UNITY_VERTEX_INPUT_INSTANCE_ID
		};

		uniform float _NormalMapScale;
		uniform sampler2D _WaveNormals;
		uniform float _Tiling;
		uniform sampler2D _DummyTex;
		uniform sampler2D _Albedo;
		uniform float4 _Albedo_ST;
		uniform float _SteepnessRange;
		uniform float _SteepnessFalloff;
		uniform float _SteepnessCoeff;
		uniform float _ForcedSpecGlossiness;
		uniform float4 _ForcedSpecColor;
		uniform float _ForcedSpecFresnel;
		uniform float _ForcedSpecIntensity;
		uniform float4 _SpecColorNorm;
		uniform sampler2D _SpecMap;
		uniform float4 _SpecMap_ST;
		uniform sampler2D _GlossMap;
		uniform float4 _GlossMap_ST;
		uniform float _Smoothness;
		uniform sampler2D _WaveHeight;
		uniform sampler2D _TextureSample2;
		uniform float4 _TextureSample2_ST;
		uniform float _HeightCoeff;
		uniform float _Steepness;
		uniform float _Wavelength;
		uniform float _Amplitude;
		uniform float _NumberOfWaves;
		uniform float _Speed;
		uniform float _TessMaxDistance;
		uniform float _TessAmount;

		float4 tessFunction( appdata v0, appdata v1, appdata v2 )
		{
			return UnityDistanceBasedTess( v0.vertex, v1.vertex, v2.vertex, 0.0,_TessMaxDistance,_TessAmount);
		}

		void vertexDataFunc( inout appdata v )
		{
			float2 temp_cast_0 = (_Tiling).xx;
			v.texcoord.xy = v.texcoord.xy * temp_cast_0 + float2( 0,0 );
			float4 _Color2 = float4(0.9888438,0.9191176,1,0);
			float4 temp_output_67_0 = ( ( float4( UnpackScaleNormal( tex2Dlod( _WaveNormals, float4( (abs( v.texcoord.xy+_Time[1] * float2(-0.01,-0.01 ))), 0.0 , 0.0 ) ) ,_NormalMapScale ) , 0.0 ) * _Color2 ) + ( float4( UnpackNormal( tex2Dlod( _WaveNormals, float4( (abs( v.texcoord.xy+_Time[1] * float2(0.01,0.01 ))), 0.0 , 0.0 ) ) ) , 0.0 ) * _Color2 ) );
			float4 temp_output_36_0 = ( temp_output_67_0 * 0.2 );
			float componentMask37 = temp_output_36_0.r;
			float componentMask38 = temp_output_36_0.g;
			float componentMask39 = temp_output_36_0.b;
			float4 uv_TextureSample2 = float4(v.texcoord * _TextureSample2_ST.xy + _TextureSample2_ST.zw, 0 ,0);
			float4 clampResult45 = clamp( ( ( ( tex2Dlod( _WaveHeight, temp_output_67_0 ) * tex2Dlod( _WaveHeight, temp_output_67_0 ).r ) * ( componentMask37 + componentMask38 + componentMask39 ) ) + tex2Dlod( _TextureSample2, uv_TextureSample2 ) ) , float4( 0,0,0,0 ) , float4( 0.1,0.1,0.1,0 ) );
			float3 ase_vertexNormal = v.normal.xyz;
			float temp_output_15_0_g57 = ( ( 2.0 * UNITY_PI ) / _Wavelength );
			float temp_output_58_0_g57 = ( ( _Steepness / ( ( temp_output_15_0_g57 * _Amplitude ) * ( _NumberOfWaves * ( 2.0 * UNITY_PI ) ) ) ) * _Amplitude );
			float3 componentMask5_g57 = float4(1,0.8896552,0,1).rgb;
			float componentMask64_g57 = componentMask5_g57.x;
			float3 normalizeResult4_g57 = normalize( componentMask5_g57 );
			float3 ase_worldPos = mul(unity_ObjectToWorld, v.vertex);
			float4 transform69_g57 = mul(unity_WorldToObject,float4( ase_worldPos , 0.0 ));
			float3 componentMask3_g57 = transform69_g57.xyz;
			float dotResult11_g57 = dot( normalizeResult4_g57 , componentMask3_g57 );
			float temp_output_21_0_g57 = ( ( dotResult11_g57 * temp_output_15_0_g57 ) + ( ( _Speed * temp_output_15_0_g57 ) * _Time.y ) );
			float temp_output_62_0_g57 = cos( temp_output_21_0_g57 );
			float componentMask65_g57 = componentMask5_g57.y;
			float4 appendResult54_g57 = (float4(( temp_output_58_0_g57 * ( componentMask64_g57 * temp_output_62_0_g57 ) ) , ( temp_output_58_0_g57 * ( temp_output_62_0_g57 * componentMask65_g57 ) ) , ( sin( temp_output_21_0_g57 ) * ( _Amplitude * 2.0 ) ) , 0.0));
			float temp_output_15_0_g56 = ( ( 2.0 * UNITY_PI ) / _Wavelength );
			float temp_output_58_0_g56 = ( ( _Steepness / ( ( temp_output_15_0_g56 * _Amplitude ) * ( _NumberOfWaves * ( 2.0 * UNITY_PI ) ) ) ) * _Amplitude );
			float3 componentMask5_g56 = ( float4(0.7379313,0,1,1) * -1.0 ).rgb;
			float componentMask64_g56 = componentMask5_g56.x;
			float3 normalizeResult4_g56 = normalize( componentMask5_g56 );
			float4 transform69_g56 = mul(unity_WorldToObject,float4( ase_worldPos , 0.0 ));
			float3 componentMask3_g56 = transform69_g56.xyz;
			float dotResult11_g56 = dot( normalizeResult4_g56 , componentMask3_g56 );
			float temp_output_21_0_g56 = ( ( dotResult11_g56 * temp_output_15_0_g56 ) + ( ( _Speed * temp_output_15_0_g56 ) * _Time.y ) );
			float temp_output_62_0_g56 = cos( temp_output_21_0_g56 );
			float componentMask65_g56 = componentMask5_g56.y;
			float4 appendResult54_g56 = (float4(( temp_output_58_0_g56 * ( componentMask64_g56 * temp_output_62_0_g56 ) ) , ( temp_output_58_0_g56 * ( temp_output_62_0_g56 * componentMask65_g56 ) ) , ( sin( temp_output_21_0_g56 ) * ( _Amplitude * 2.0 ) ) , 0.0));
			float temp_output_15_0_g55 = ( ( 2.0 * UNITY_PI ) / _Wavelength );
			float temp_output_58_0_g55 = ( ( _Steepness / ( ( temp_output_15_0_g55 * _Amplitude ) * ( _NumberOfWaves * ( 2.0 * UNITY_PI ) ) ) ) * _Amplitude );
			float3 componentMask5_g55 = ( float4(0,0.9586205,1,1) * -1.0 ).rgb;
			float componentMask64_g55 = componentMask5_g55.x;
			float3 normalizeResult4_g55 = normalize( componentMask5_g55 );
			float4 transform69_g55 = mul(unity_WorldToObject,float4( ase_worldPos , 0.0 ));
			float3 componentMask3_g55 = transform69_g55.xyz;
			float dotResult11_g55 = dot( normalizeResult4_g55 , componentMask3_g55 );
			float temp_output_21_0_g55 = ( ( dotResult11_g55 * temp_output_15_0_g55 ) + ( ( _Speed * temp_output_15_0_g55 ) * _Time.y ) );
			float temp_output_62_0_g55 = cos( temp_output_21_0_g55 );
			float componentMask65_g55 = componentMask5_g55.y;
			float4 appendResult54_g55 = (float4(( temp_output_58_0_g55 * ( componentMask64_g55 * temp_output_62_0_g55 ) ) , ( temp_output_58_0_g55 * ( temp_output_62_0_g55 * componentMask65_g55 ) ) , ( sin( temp_output_21_0_g55 ) * ( _Amplitude * 2.0 ) ) , 0.0));
			float temp_output_15_0_g58 = ( ( 2.0 * UNITY_PI ) / _Wavelength );
			float temp_output_58_0_g58 = ( ( _Steepness / ( ( temp_output_15_0_g58 * _Amplitude ) * ( _NumberOfWaves * ( 2.0 * UNITY_PI ) ) ) ) * _Amplitude );
			float3 componentMask5_g58 = ( float4(1,0.4344828,0,1) * -1.0 ).rgb;
			float componentMask64_g58 = componentMask5_g58.x;
			float3 normalizeResult4_g58 = normalize( componentMask5_g58 );
			float4 transform69_g58 = mul(unity_WorldToObject,float4( ase_worldPos , 0.0 ));
			float3 componentMask3_g58 = transform69_g58.xyz;
			float dotResult11_g58 = dot( normalizeResult4_g58 , componentMask3_g58 );
			float temp_output_21_0_g58 = ( ( dotResult11_g58 * temp_output_15_0_g58 ) + ( ( _Speed * temp_output_15_0_g58 ) * _Time.y ) );
			float temp_output_62_0_g58 = cos( temp_output_21_0_g58 );
			float componentMask65_g58 = componentMask5_g58.y;
			float4 appendResult54_g58 = (float4(( temp_output_58_0_g58 * ( componentMask64_g58 * temp_output_62_0_g58 ) ) , ( temp_output_58_0_g58 * ( temp_output_62_0_g58 * componentMask65_g58 ) ) , ( sin( temp_output_21_0_g58 ) * ( _Amplitude * 2.0 ) ) , 0.0));
			v.vertex.xyz += ( ( clampResult45 * float4( ase_vertexNormal , 0.0 ) * _HeightCoeff ) + ( ( appendResult54_g57 + appendResult54_g56 + appendResult54_g55 + appendResult54_g58 ) + ( appendResult54_g55 + appendResult54_g58 ) ) ).xyz;
		}

		void surf( Input i , inout SurfaceOutputStandardSpecular o )
		{
			float2 temp_cast_0 = (_Tiling).xx;
			float2 texCoordDummy90 = i.uv_DummyTex*temp_cast_0 + float2( 0,0 );
			float4 _Color2 = float4(0.9888438,0.9191176,1,0);
			float4 temp_output_67_0 = ( ( float4( UnpackScaleNormal( tex2D( _WaveNormals, (abs( texCoordDummy90+_Time[1] * float2(-0.01,-0.01 ))) ) ,_NormalMapScale ) , 0.0 ) * _Color2 ) + ( float4( UnpackNormal( tex2D( _WaveNormals, (abs( texCoordDummy90+_Time[1] * float2(0.01,0.01 ))) ) ) , 0.0 ) * _Color2 ) );
			o.Normal = temp_output_67_0.rgb;
			float2 uv_Albedo = i.uv_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
			float4 tex2DNode207 = tex2D( _Albedo, uv_Albedo );
			float3 ase_worldPos = i.worldPos;
			float4 clampResult2 = clamp( ( ( ( ase_worldPos.y - _SteepnessRange ) + float4(1,1,1,1) ) * _SteepnessFalloff ) , float4( 0,0,0,0 ) , float4( 1,1,1,1 ) );
			float4 lerpResult1 = lerp( float4(0.02681661,0.03763276,0.05882353,1) , float4(0.6691177,1,0.9452333,1) , clampResult2.r);
			float4 temp_output_204_0 = ( lerpResult1 * _SteepnessCoeff );
			o.Albedo = ( tex2DNode207 + tex2DNode207 + temp_output_204_0 + tex2DNode207 ).xyz;
			float componentMask170 = temp_output_67_0.r;
			float4 temp_output_75_0 = ( componentMask170 * ( ( 0.0 + 0.5 ) * float4(0.875,0.875,0.875,0) ) );
			float3 worldViewDir = normalize( UnityWorldSpaceViewDir( i.worldPos ) );
			float fresnelFinalVal81 = (0.0 + 1.0*pow( 1.0 - dot( WorldNormalVector( i , UnpackNormal( tex2D( _WaveNormals, temp_output_67_0.rg ) ) ), worldViewDir ) , 1.0));
			float4 lerpResult83 = lerp( ( temp_output_75_0 * 0.1 ) , ( temp_output_75_0 * 0.4 ) , fresnelFinalVal81);
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			float3 temp_output_124_0 = ( ase_worldlightDir * -1.0 );
			float componentMask129 = temp_output_124_0.x;
			float componentMask130 = temp_output_124_0.y;
			float componentMask131 = temp_output_124_0.z;
			float4 appendResult135 = (float4(( componentMask129 * 1.0 ) , ( componentMask130 * -1.0 ) , componentMask131 , 0.0));
			float dotResult94 = dot( appendResult135 , float4( worldViewDir , 0.0 ) );
			float clampResult95 = clamp( dotResult94 , 0.0 , 1.0 );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float fresnelFinalVal99 = (0.0 + 1.0*pow( 1.0 - dot( ase_worldNormal, worldViewDir ) , _ForcedSpecFresnel));
			float4 temp_output_101_0 = ( pow( clampResult95 , _ForcedSpecGlossiness ) * _ForcedSpecColor * fresnelFinalVal99 );
			float3 temp_cast_13 = (128.0).xxx;
			float componentMask114 = ( ase_worldPos - temp_cast_13 ).z;
			float clampResult117 = clamp( ( componentMask114 * 0.003 ) , 0.0 , 1.0 );
			float4 lerpResult106 = lerp( ( temp_output_101_0 * _ForcedSpecIntensity ) , ( temp_output_101_0 * 1.0 ) , clampResult117);
			o.Emission = ( lerpResult83 + lerpResult106 ).rgb;
			float2 uv_SpecMap = i.uv_texcoord * _SpecMap_ST.xy + _SpecMap_ST.zw;
			o.Specular = ( _SpecColorNorm * tex2D( _SpecMap, uv_SpecMap ) * temp_output_204_0 ).rgb;
			float2 uv_GlossMap = i.uv_texcoord * _GlossMap_ST.xy + _GlossMap_ST.zw;
			o.Smoothness = ( tex2D( _GlossMap, uv_GlossMap ) * _Smoothness ).x;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=13101
2567;29;2546;1364;6273.873;-1197.309;1;True;True
Node;AmplifyShaderEditor.RangedFloatNode;91;-8653.49,109.7717;Float;False;Property;_Tiling;Tiling;12;0;1;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.CommentaryNode;168;-3535.742,600.4501;Float;False;3609.185;1159.396;Specular;33;106;117;102;104;103;101;105;115;116;114;100;99;96;112;109;95;113;97;110;94;128;135;136;131;133;129;132;130;137;124;92;125;172;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;90;-8493.928,96.92925;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;125;-3386.907,853.4525;Float;False;Constant;_Float14;Float 14;13;0;-1;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;92;-3384.398,726.1741;Float;False;1;0;FLOAT;0.0;False;1;FLOAT3
Node;AmplifyShaderEditor.PannerNode;89;-8206.928,132.9293;Float;False;0.01;0.01;2;0;FLOAT2;0,0;False;1;FLOAT;0.0;False;1;FLOAT2
Node;AmplifyShaderEditor.PannerNode;157;-8179.316,575.682;Float;False;-0.01;-0.01;2;0;FLOAT2;0,0;False;1;FLOAT;0.0;False;1;FLOAT2
Node;AmplifyShaderEditor.RangedFloatNode;197;-7978.262,805.9094;Float;False;Property;_NormalMapScale;Normal Map Scale;11;0;1;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;124;-3110.068,838.9052;Float;True;2;2;0;FLOAT3;0.0;False;1;FLOAT;0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.SamplerNode;56;-7779.467,244.4504;Float;True;Property;_TextureSample3;Texture Sample 3;6;0;Assets/AmplifyShaderEditor/Examples/Assets/Textures/Misc/SmallWaves.png;True;0;True;bump;Auto;True;Instance;55;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ColorNode;65;-7670.744,725.3165;Float;False;Constant;_Color2;Color 2;7;0;0.9888438,0.9191176,1,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;55;-7770.862,459.6525;Float;True;Property;_WaveNormals;WaveNormals;10;0;Assets/AmplifyShaderEditor/Examples/Assets/Textures/Misc/SmallWaves.png;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;132;-2802.502,673.7123;Float;False;Constant;_Float15;Float 15;13;0;1;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;137;-2827.502,857.2124;Float;False;Constant;_Float16;Float 16;13;0;-1;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.ComponentMaskNode;130;-2819.502,941.7124;Float;False;False;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT
Node;AmplifyShaderEditor.ComponentMaskNode;129;-2809.502,758.7123;Float;False;True;False;False;True;1;0;FLOAT3;0,0,0,0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;66;-7366.846,446.1164;Float;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;64;-7373.245,318.7163;Float;False;2;2;0;FLOAT3;0.0;False;1;COLOR;0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.ComponentMaskNode;131;-2820.502,1052.713;Float;False;False;False;True;True;1;0;FLOAT3;0,0,0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;136;-2595.502,854.2124;Float;False;2;2;0;FLOAT;0,0,0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;133;-2553.502,683.7123;Float;False;2;2;0;FLOAT;0,0,0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;67;-7056.442,354.0163;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0.0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;68;-6286.352,1252.885;Float;False;Constant;_Float2;Float 2;7;0;0.2;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;10;-3371.809,-1607.073;Float;False;Property;_SteepnessRange;Steepness Range;1;0;59.59169;0;20;0;1;FLOAT
Node;AmplifyShaderEditor.DynamicAppendNode;135;-2324.502,718.7123;Float;False;FLOAT4;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT4
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;128;-2823.936,1197.147;Float;True;World;0;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.WorldPosInputsNode;11;-3261.948,-2022.236;Float;True;0;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;-6103.68,1140.097;Float;True;2;2;0;COLOR;0.0;False;1;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;78;-2490.402,-22.0598;Float;False;Constant;_Float4;Float 4;8;0;0;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.ColorNode;167;-2765.391,-1436.921;Float;False;Constant;_Color9;Color 9;13;0;1,1,1,1;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.WorldPosInputsNode;110;-2226.928,1365.317;Float;True;0;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.DotProductOpNode;94;-2114.001,866.82;Float;True;2;0;FLOAT4;0.0;False;1;FLOAT3;0,0,0,0;False;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;79;-2488.233,60.34738;Float;False;Constant;_Float5;Float 5;8;0;0.5;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleSubtractOpNode;9;-2915.859,-1838.376;Float;True;2;0;FLOAT;0.0;False;1;FLOAT;0,0,0;False;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;44;-6170.355,1617.127;Float;True;Property;_TextureSample1;Texture Sample 1;6;0;None;True;0;False;white;Auto;False;Instance;42;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;113;-2107.648,1599.03;Float;False;Constant;_Float12;Float 12;8;0;128;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.ComponentMaskNode;39;-5795.336,1362.189;Float;False;False;False;True;False;1;0;COLOR;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;42;-6176.749,1404.235;Float;True;Property;_WaveHeight;WaveHeight;8;0;Assets/AmplifyShaderEditor/Examples/Community/ForceShield/ForceShieldWaves.png;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ComponentMaskNode;37;-5794.146,1195.544;Float;False;True;False;False;False;1;0;COLOR;0,0,0,0;False;1;FLOAT
Node;AmplifyShaderEditor.ComponentMaskNode;38;-5796.523,1283.717;Float;False;False;True;False;False;1;0;COLOR;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.ColorNode;26;-5543.225,3866.902;Float;False;Constant;_Color6;Color 6;0;0;1,0.4344828,0,1;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;109;-1887.508,1305.412;Float;False;Property;_ForcedSpecFresnel;Forced Spec Fresnel;13;0;6;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.ClampOpNode;95;-1789.121,801.2897;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;6;-2346.939,-1712.343;Float;False;2;2;0;FLOAT;0.0;False;1;COLOR;0.0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;97;-1794,1013.82;Float;False;Property;_ForcedSpecGlossiness;Forced Spec Glossiness;16;0;3;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.ColorNode;24;-6017.252,2800.795;Float;False;Constant;_Color4;Color 4;0;0;0.7379313,0,1,1;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;154;-5508.875,4158.058;Float;False;Constant;_Float9;Float 9;11;0;-1;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.ColorNode;25;-6007.201,3647.784;Float;False;Constant;_Color5;Color 5;0;0;0,0.9586205,1,1;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;180;-5898.729,3017.527;Float;False;Constant;_Float3;Float 3;15;0;-1;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;152;-5985.875,3870.558;Float;False;Constant;_Float0;Float 0;11;0;-1;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;-5660.355,1645.227;Float;True;2;2;0;FLOAT4;0.0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.SimpleAddOpNode;76;-2212.82,-26.39685;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.ColorNode;80;-2488.233,172.0308;Float;False;Constant;_Color7;Color 7;8;0;0.875,0.875,0.875,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;40;-5392.273,1188.599;Float;False;3;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;7;-2346.878,-1485.998;Float;False;Property;_SteepnessFalloff;Steepness Falloff;2;0;0.3684832;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleSubtractOpNode;112;-1869.247,1443.83;Float;False;2;0;FLOAT3;0.0;False;1;FLOAT;0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.FresnelNode;99;-1400.923,1178.651;Float;True;4;0;FLOAT3;0,0,0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;3;FLOAT;5.0;False;1;FLOAT
Node;AmplifyShaderEditor.ColorNode;22;-5578.159,2684.531;Float;False;Constant;_Color0;Color 0;0;0;1,0.8896552,0,1;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;151;-5781.875,3739.558;Float;False;2;2;0;COLOR;0.0;False;1;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.ComponentMaskNode;114;-1636.247,1457.83;Float;False;False;False;True;True;1;0;FLOAT3;0,0,0,0;False;1;FLOAT
Node;AmplifyShaderEditor.PowerNode;96;-1570,877.82;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;179;-5716.435,2907.346;Float;False;2;2;0;COLOR;0.0;False;1;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SamplerNode;226;-5820.694,1936.555;Float;True;Property;_TextureSample2;Texture Sample 2;23;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;30;-7126.09,3392.23;Float;False;Property;_Speed;Speed;5;0;1;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-2009.89,-1797.904;Float;False;2;2;0;COLOR;0.0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SamplerNode;74;-2633.092,-406.0844;Float;True;Property;_TextureSample4;Texture Sample 4;7;0;None;True;0;False;white;Auto;True;Instance;55;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;27;-7126.087,3118.838;Float;False;Property;_Steepness;Steepness;7;0;1;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;116;-1595.247,1581.83;Float;False;Constant;_Float13;Float 13;8;0;0.003;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;31;-7126.089,3202.245;Float;False;Property;_Wavelength;Wavelength;4;0;1;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;28;-7129.178,3038.519;Float;False;Property;_NumberOfWaves;Number Of Waves;6;0;1;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;77;-2005.718,-41.57713;Float;True;2;2;0;FLOAT;0,0,0;False;1;COLOR;0.0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;153;-5246.875,4038.058;Float;True;2;2;0;COLOR;0.0;False;1;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.ColorNode;100;-1149.724,699.3677;Float;False;Property;_ForcedSpecColor;Forced Spec Color;17;0;0.05147058,0.450507,1,1;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ComponentMaskNode;170;-4917.207,312.9326;Float;False;True;False;False;False;1;0;COLOR;0,0,0,0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;-5218.144,1308.812;Float;True;2;2;0;FLOAT4;0.0;False;1;FLOAT;0.0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.RangedFloatNode;29;-7126.088,3294.921;Float;False;Property;_Amplitude;Amplitude;0;0;11;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.ColorNode;3;-1706.647,-2313.02;Float;False;Constant;_PeakColor;Peak Color;1;0;0.6691177,1,0.9452333,1;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.FunctionNode;183;-5105.432,3395.993;Float;False;GerstnerWaveFunction;-1;;55;6;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;COLOR;0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.RangedFloatNode;85;-1749.822,-139.1646;Float;False;Constant;_Float7;Float 7;8;0;0.4;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;103;-992.436,1069.402;Float;False;Property;_ForcedSpecIntensity;Forced Spec Intensity;15;0;12;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.ClampOpNode;2;-1568.593,-1739.192;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,1;False;1;COLOR
Node;AmplifyShaderEditor.SimpleAddOpNode;227;-5268.753,1837.461;Float;False;2;2;0;FLOAT4;0.0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.FunctionNode;181;-5093.887,2906.206;Float;False;GerstnerWaveFunction;-1;;57;6;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;COLOR;0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.WorldNormalVector;203;-2108.77,-293.4438;Float;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;87;-1720.546,-33.98701;Float;False;Constant;_Float8;Float 8;8;0;0.1;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.FunctionNode;182;-5099.685,3118.042;Float;False;GerstnerWaveFunction;-1;;56;6;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;COLOR;0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.FunctionNode;184;-5108.432,3597.993;Float;False;GerstnerWaveFunction;-1;;58;6;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;COLOR;0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.RangedFloatNode;82;-1706.778,172.2025;Float;False;Constant;_Floaty;Floaty;8;0;1;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;115;-1334.047,1488.33;Float;True;2;2;0;FLOAT;0,0,0,0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;105;-927.3376,1224.292;Float;False;Constant;_Float11;Float 11;8;0;1;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.ColorNode;4;-1707.647,-2046.018;Float;False;Constant;_ValleyColor;Valley Color;0;0;0.02681661,0.03763276,0.05882353,1;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;101;-900.0392,903.0089;Float;False;3;3;0;FLOAT;0.0;False;1;COLOR;0.0;False;2;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;75;-1821.386,-247.5949;Float;False;2;2;0;FLOAT;0.0;False;1;COLOR;0;False;1;COLOR
Node;AmplifyShaderEditor.NormalVertexDataNode;46;-4909.029,1653.168;Float;False;0;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;104;-694.2496,1168.645;Float;False;2;2;0;COLOR;0.0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;102;-669.8004,839.2097;Float;False;2;2;0;COLOR;0.0;False;1;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.ClampOpNode;45;-4925.354,1329.127;Float;True;3;0;FLOAT4;0.0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT4;0.1,0.1,0.1,0;False;1;FLOAT4
Node;AmplifyShaderEditor.SimpleAddOpNode;173;-4509.009,3350.311;Float;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.LerpOp;1;-1289.992,-1865.518;Float;True;3;0;COLOR;0.0,0,0,0;False;1;COLOR;0.0;False;2;FLOAT;0.0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;86;-1521.034,-116.3942;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.FresnelNode;81;-1472.24,36.49279;Float;False;4;0;FLOAT3;0,0,0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;3;FLOAT;5.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;17;-4511.397,3041.991;Float;False;4;4;0;FLOAT4;0.0;False;1;FLOAT4;0.0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.ClampOpNode;117;-934.9001,1495.33;Float;True;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;205;-1125.945,-1096.425;Float;False;Property;_SteepnessCoeff;Steepness Coeff;3;0;3;0;20;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;190;-4943.101,1814.918;Float;False;Property;_HeightCoeff;Height Coeff;9;0;1;0;10;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;84;-1547.057,-245.4264;Float;False;2;2;0;COLOR;0;False;1;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;194;158.7994,675.5712;Float;False;Property;_TessAmount;Tess Amount;20;0;50;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;47;-4613.149,1433.893;Float;False;3;3;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.SimpleAddOpNode;174;-4152.009,3202.311;Float;False;2;2;0;FLOAT4;0.0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.SamplerNode;207;-794.4735,-582.3014;Float;True;Property;_Albedo;Albedo;21;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ColorNode;165;-221.3198,-1064.916;Float;False;Property;_SpecColorNorm;Spec Color Norm;14;0;1,1,1,1;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;219;-434.173,-444.2554;Float;True;Property;_SpecMap;Spec Map;24;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;164;-140.6979,-38.11359;Float;False;Property;_Smoothness;Smoothness;18;0;0;0;2;0;1;FLOAT
Node;AmplifyShaderEditor.LerpOp;106;-243.7124,957.6058;Float;True;3;0;COLOR;0.0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0.0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;204;-775.9479,-1121.892;Float;True;2;2;0;COLOR;0.0;False;1;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.LerpOp;83;-1178.393,-159.7664;Float;True;3;0;COLOR;0.0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;195;149.7994,782.5712;Float;False;Property;_TessMaxDistance;Tess Max Distance;19;0;300;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;225;-253.5353,-243.9103;Float;True;Property;_GlossMap;Gloss Map;22;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;218;18.05591,-750.374;Float;False;3;3;0;COLOR;0.0;False;1;FLOAT4;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleAddOpNode;49;-3471.747,2592.583;Float;True;2;2;0;FLOAT4;0.0;False;1;FLOAT4;0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.SimpleAddOpNode;206;-400.5735,-670.7012;Float;True;4;4;0;FLOAT4;0.0,0,0,0;False;1;FLOAT4;0.0;False;2;COLOR;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.SimpleAddOpNode;88;-3.102821,193.5363;Float;True;2;2;0;COLOR;0.0;False;1;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;60;-8679.513,350.1022;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;63;-8967.043,595.6166;Float;False;Constant;_Float0;Float 0;7;0;0.2;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.EdgeLengthTessNode;71;299.1474,565.7924;Float;False;1;0;FLOAT;0.0;False;1;FLOAT4
Node;AmplifyShaderEditor.WorldNormalVector;172;-2230.585,1131.844;Float;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;220;90.92481,-277.1395;Float;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.DistanceBasedTessNode;193;309.7994,651.5712;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;1;FLOAT4
Node;AmplifyShaderEditor.SimpleTimeNode;61;-8965.743,734.7167;Float;False;1;0;FLOAT;1.0;False;1;FLOAT
Node;AmplifyShaderEditor.Vector2Node;57;-8454.414,390.8022;Float;False;Constant;_Vector0;Vector 0;7;0;0.5,0.5;0;3;FLOAT2;FLOAT;FLOAT
Node;AmplifyShaderEditor.RotatorNode;69;-8201.729,365.3855;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;1;FLOAT2
Node;AmplifyShaderEditor.PannerNode;58;-8461.514,251.1022;Float;False;1;1;2;0;FLOAT2;0,0;False;1;FLOAT;0.0;False;1;FLOAT2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;62;-8617.343,617.7167;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SinTimeNode;142;567.7529,1700.295;Float;False;0;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;59;-9023.513,206.1022;Float;False;Constant;_MediumWaveScale;Medium Wave Scale;7;0;8;0;10;0;1;FLOAT
Node;AmplifyShaderEditor.WorldNormalVector;221;-3222.649,-2237.731;Float;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;631.52,-5.032041;Float;False;True;7;Float;ASEMaterialInspector;0;0;StandardSpecular;GerstnerWaves;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;False;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;True;0;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;OBJECT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;90;0;91;0
WireConnection;89;0;90;0
WireConnection;157;0;90;0
WireConnection;124;0;92;0
WireConnection;124;1;125;0
WireConnection;56;1;89;0
WireConnection;55;1;157;0
WireConnection;55;5;197;0
WireConnection;130;0;124;0
WireConnection;129;0;124;0
WireConnection;66;0;56;0
WireConnection;66;1;65;0
WireConnection;64;0;55;0
WireConnection;64;1;65;0
WireConnection;131;0;124;0
WireConnection;136;0;130;0
WireConnection;136;1;137;0
WireConnection;133;0;129;0
WireConnection;133;1;132;0
WireConnection;67;0;64;0
WireConnection;67;1;66;0
WireConnection;135;0;133;0
WireConnection;135;1;136;0
WireConnection;135;2;131;0
WireConnection;36;0;67;0
WireConnection;36;1;68;0
WireConnection;94;0;135;0
WireConnection;94;1;128;0
WireConnection;9;0;11;2
WireConnection;9;1;10;0
WireConnection;44;1;67;0
WireConnection;39;0;36;0
WireConnection;42;1;67;0
WireConnection;37;0;36;0
WireConnection;38;0;36;0
WireConnection;95;0;94;0
WireConnection;6;0;9;0
WireConnection;6;1;167;0
WireConnection;43;0;42;0
WireConnection;43;1;44;1
WireConnection;76;0;78;0
WireConnection;76;1;79;0
WireConnection;40;0;37;0
WireConnection;40;1;38;0
WireConnection;40;2;39;0
WireConnection;112;0;110;0
WireConnection;112;1;113;0
WireConnection;99;3;109;0
WireConnection;151;0;25;0
WireConnection;151;1;152;0
WireConnection;114;0;112;0
WireConnection;96;0;95;0
WireConnection;96;1;97;0
WireConnection;179;0;24;0
WireConnection;179;1;180;0
WireConnection;5;0;6;0
WireConnection;5;1;7;0
WireConnection;74;1;67;0
WireConnection;77;0;76;0
WireConnection;77;1;80;0
WireConnection;153;0;26;0
WireConnection;153;1;154;0
WireConnection;170;0;67;0
WireConnection;41;0;43;0
WireConnection;41;1;40;0
WireConnection;183;0;31;0
WireConnection;183;1;30;0
WireConnection;183;2;29;0
WireConnection;183;3;28;0
WireConnection;183;4;27;0
WireConnection;183;5;151;0
WireConnection;2;0;5;0
WireConnection;227;0;41;0
WireConnection;227;1;226;0
WireConnection;181;0;31;0
WireConnection;181;1;30;0
WireConnection;181;2;29;0
WireConnection;181;3;28;0
WireConnection;181;4;27;0
WireConnection;181;5;22;0
WireConnection;203;0;74;0
WireConnection;182;0;31;0
WireConnection;182;1;30;0
WireConnection;182;2;29;0
WireConnection;182;3;28;0
WireConnection;182;4;27;0
WireConnection;182;5;179;0
WireConnection;184;0;31;0
WireConnection;184;1;30;0
WireConnection;184;2;29;0
WireConnection;184;3;28;0
WireConnection;184;4;27;0
WireConnection;184;5;153;0
WireConnection;115;0;114;0
WireConnection;115;1;116;0
WireConnection;101;0;96;0
WireConnection;101;1;100;0
WireConnection;101;2;99;0
WireConnection;75;0;170;0
WireConnection;75;1;77;0
WireConnection;104;0;101;0
WireConnection;104;1;105;0
WireConnection;102;0;101;0
WireConnection;102;1;103;0
WireConnection;45;0;227;0
WireConnection;173;0;183;0
WireConnection;173;1;184;0
WireConnection;1;0;4;0
WireConnection;1;1;3;0
WireConnection;1;2;2;0
WireConnection;86;0;75;0
WireConnection;86;1;87;0
WireConnection;81;0;203;0
WireConnection;81;3;82;0
WireConnection;17;0;181;0
WireConnection;17;1;182;0
WireConnection;17;2;183;0
WireConnection;17;3;184;0
WireConnection;117;0;115;0
WireConnection;84;0;75;0
WireConnection;84;1;85;0
WireConnection;47;0;45;0
WireConnection;47;1;46;0
WireConnection;47;2;190;0
WireConnection;174;0;17;0
WireConnection;174;1;173;0
WireConnection;106;0;102;0
WireConnection;106;1;104;0
WireConnection;106;2;117;0
WireConnection;204;0;1;0
WireConnection;204;1;205;0
WireConnection;83;0;86;0
WireConnection;83;1;84;0
WireConnection;83;2;81;0
WireConnection;218;0;165;0
WireConnection;218;1;219;0
WireConnection;218;2;204;0
WireConnection;49;0;47;0
WireConnection;49;1;174;0
WireConnection;206;0;207;0
WireConnection;206;1;207;0
WireConnection;206;2;204;0
WireConnection;206;3;207;0
WireConnection;88;0;83;0
WireConnection;88;1;106;0
WireConnection;60;0;61;0
WireConnection;60;1;59;0
WireConnection;172;0;67;0
WireConnection;220;0;225;0
WireConnection;220;1;164;0
WireConnection;193;0;194;0
WireConnection;193;2;195;0
WireConnection;69;0;58;0
WireConnection;69;1;57;0
WireConnection;58;0;60;0
WireConnection;58;1;62;0
WireConnection;62;0;61;0
WireConnection;62;1;63;0
WireConnection;221;0;67;0
WireConnection;0;0;206;0
WireConnection;0;1;67;0
WireConnection;0;2;88;0
WireConnection;0;3;218;0
WireConnection;0;4;220;0
WireConnection;0;11;49;0
WireConnection;0;14;193;0
ASEEND*/
//CHKSM=5E8A0D48F360303A13662F6221A6544F3A912E0F