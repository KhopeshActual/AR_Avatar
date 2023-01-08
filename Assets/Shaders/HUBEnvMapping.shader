// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

// Shader created with Shader Forge v1.37 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.37;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:3,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:True,hqlp:False,rprd:True,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:2865,x:33839,y:35244,varname:node_2865,prsc:2|diff-8573-OUT,spec-9760-R,gloss-2719-OUT,normal-9666-OUT;n:type:ShaderForge.SFN_Tex2dAsset,id:2892,x:31518,y:34949,ptovrint:False,ptlb:Albedo 1,ptin:_Albedo1,varname:node_2892,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_FragmentPosition,id:4597,x:29261,y:35631,varname:node_4597,prsc:2;n:type:ShaderForge.SFN_NormalVector,id:9412,x:29350,y:34980,prsc:2,pt:False;n:type:ShaderForge.SFN_Multiply,id:4198,x:31529,y:35342,varname:node_4198,prsc:2|A-5279-OUT,B-5279-OUT;n:type:ShaderForge.SFN_Tex2dAsset,id:8229,x:31518,y:35157,ptovrint:False,ptlb:Metallic 1,ptin:_Metallic1,varname:node_8229,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:2,isnm:False;n:type:ShaderForge.SFN_Tex2dAsset,id:7842,x:31270,y:35551,ptovrint:False,ptlb:Normals 1,ptin:_Normals1,varname:node_7842,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Append,id:4518,x:31037,y:35539,varname:node_4518,prsc:2|A-5382-G,B-5382-B;n:type:ShaderForge.SFN_Append,id:6253,x:31049,y:35690,varname:node_6253,prsc:2|A-5382-R,B-5382-B;n:type:ShaderForge.SFN_Append,id:328,x:31049,y:35845,varname:node_328,prsc:2|A-5382-R,B-5382-G;n:type:ShaderForge.SFN_Multiply,id:6869,x:30535,y:35493,varname:node_6869,prsc:2|A-4574-OUT,B-839-OUT;n:type:ShaderForge.SFN_ValueProperty,id:1166,x:30353,y:35682,ptovrint:False,ptlb:scale,ptin:_scale,varname:node_1166,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_ComponentMask,id:5382,x:30870,y:35690,varname:node_5382,prsc:2,cc1:0,cc2:0,cc3:0,cc4:-1|IN-6869-OUT;n:type:ShaderForge.SFN_Vector1,id:2188,x:32557,y:35418,varname:node_2188,prsc:2,v1:0;n:type:ShaderForge.SFN_Code,id:4457,x:31865,y:34990,varname:node_4457,prsc:2,code:ZgBsAG8AYQB0ADMAIABDAG8AbABvAHIAWAAgAD0AIAB0AGUAeAAyAEQAKABUAGUAeAAxACwAIABXAG8AcgBsAGQAUABvAHMALgB5AHoAKQA7AAoAZgBsAG8AYQB0ADMAIABDAG8AbABvAHIAWQAgAD0AIAB0AGUAeAAyAEQAKABUAGUAeAAxACwAIABXAG8AcgBsAGQAUABvAHMALgB4AHoAKQA7AAoAZgBsAG8AYQB0ADMAIABDAG8AbABvAHIAWgAgAD0AIAB0AGUAeAAyAEQAKABUAGUAeAAxACwAIABXAG8AcgBsAGQAUABvAHMALgB4AHkAKQA7AAoACgBmAGwAbwBhAHQAMwAgAG8AdQB0AEMAbwBsAG8AcgAgAD0AIAAoAEMAbwBsAG8AcgBYACoATgBvAHIAbQBhAGwAcwAuAHgAKQArACgAQwBvAGwAbwByAFkAKgBOAG8AcgBtAGEAbABzAC4AeQApACsAKABDAG8AbABvAHIAWgAqAE4AbwByAG0AYQBsAHMALgB6ACkAOwAKAAoAcgBlAHQAdQByAG4AIABvAHUAdABDAG8AbABvAHIAOwA=,output:2,fname:Function_node_4457,width:609,height:170,input:12,input:2,input:2,input_1_label:Tex1,input_2_label:Normals,input_3_label:WorldPos|A-2892-TEX,B-4198-OUT,C-6869-OUT;n:type:ShaderForge.SFN_Code,id:5995,x:31866,y:35229,varname:node_5995,prsc:2,code:ZgBsAG8AYQB0ADQAIABDAG8AbABvAHIAWAAgAD0AIAB0AGUAeAAyAEQAKABUAGUAeAAxACwAIABXAG8AcgBsAGQAUABvAHMALgB5AHoAKQA7AAoAZgBsAG8AYQB0ADQAIABDAG8AbABvAHIAWQAgAD0AIAB0AGUAeAAyAEQAKABUAGUAeAAxACwAIABXAG8AcgBsAGQAUABvAHMALgB4AHoAKQA7AAoAZgBsAG8AYQB0ADQAIABDAG8AbABvAHIAWgAgAD0AIAB0AGUAeAAyAEQAKABUAGUAeAAxACwAIABXAG8AcgBsAGQAUABvAHMALgB4AHkAKQA7AAoACgBmAGwAbwBhAHQANAAgAG8AdQB0AEMAbwBsAG8AcgAgAD0AIAAoAEMAbwBsAG8AcgBYACoATgBvAHIAbQBhAGwAcwAuAHgAKQArACgAQwBvAGwAbwByAFkAKgBOAG8AcgBtAGEAbABzAC4AeQApACsAKABDAG8AbABvAHIAWgAqAE4AbwByAG0AYQBsAHMALgB6ACkAOwAKAAoAcgBlAHQAdQByAG4AIABvAHUAdABDAG8AbABvAHIAOwA=,output:3,fname:dfudsu,width:609,height:170,input:12,input:2,input:2,input_1_label:Tex1,input_2_label:Normals,input_3_label:WorldPos|A-8229-TEX,B-4198-OUT,C-6869-OUT;n:type:ShaderForge.SFN_ComponentMask,id:9760,x:33057,y:35236,varname:node_9760,prsc:2,cc1:0,cc2:3,cc3:-1,cc4:-1|IN-5995-OUT;n:type:ShaderForge.SFN_Code,id:9666,x:31860,y:35554,varname:node_9666,prsc:2,code:ZgBsAG8AYQB0ADMAIABDAG8AbABvAHIAWAAgAD0AIAB4ADsACgBmAGwAbwBhAHQAMwAgAEMAbwBsAG8AcgBZACAAPQAgAHkAOwAKAGYAbABvAGEAdAAzACAAQwBvAGwAbwByAFoAIAA9ACAAegA7AAoACgBmAGwAbwBhAHQAMwAgAG8AdQB0AEMAbwBsAG8AcgAgAD0AIAAoAEMAbwBsAG8AcgBYACoATgBvAHIAbQBhAGwAcwAuAHgAKQArACgAQwBvAGwAbwByAFkAKgBOAG8AcgBtAGEAbABzAC4AeQApACsAKABDAG8AbABvAHIAWgAqAE4AbwByAG0AYQBsAHMALgB6ACkAOwAKAAoAcgBlAHQAdQByAG4AIABvAHUAdABDAG8AbABvAHIAOwA=,output:2,fname:sdfgr,width:608,height:189,input:2,input:2,input:2,input:2,input_1_label:x,input_2_label:y,input_3_label:z,input_4_label:Normals|A-3288-RGB,B-8570-RGB,C-9700-RGB,D-4198-OUT;n:type:ShaderForge.SFN_Tex2d,id:3288,x:31529,y:35551,varname:node_3288,prsc:2,ntxv:0,isnm:False|UVIN-4518-OUT,TEX-7842-TEX;n:type:ShaderForge.SFN_Tex2d,id:8570,x:31529,y:35689,varname:node_8570,prsc:2,ntxv:0,isnm:False|UVIN-6253-OUT,TEX-7842-TEX;n:type:ShaderForge.SFN_Tex2d,id:9700,x:31529,y:35824,varname:node_9700,prsc:2,ntxv:0,isnm:False|UVIN-328-OUT,TEX-7842-TEX;n:type:ShaderForge.SFN_Color,id:1674,x:32375,y:34812,ptovrint:False,ptlb:Color,ptin:_Color,varname:node_1674,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:8573,x:32602,y:34974,varname:node_8573,prsc:2|A-1674-RGB,B-4457-OUT;n:type:ShaderForge.SFN_Code,id:1958,x:31874,y:36102,varname:node_1958,prsc:2,code:ZgBsAG8AYQB0ADMAIABDAG8AbABvAHIAWAAgAD0AIAB0AGUAeAAyAEQAKABUAGUAeAAxACwAIABXAG8AcgBsAGQAUABvAHMALgB5AHoAKQA7AAoAZgBsAG8AYQB0ADMAIABDAG8AbABvAHIAWQAgAD0AIAB0AGUAeAAyAEQAKABUAGUAeAAxACwAIABXAG8AcgBsAGQAUABvAHMALgB4AHoAKQA7AAoAZgBsAG8AYQB0ADMAIABDAG8AbABvAHIAWgAgAD0AIAB0AGUAeAAyAEQAKABUAGUAeAAxACwAIABXAG8AcgBsAGQAUABvAHMALgB4AHkAKQA7AAoACgBmAGwAbwBhAHQAMwAgAG8AdQB0AEMAbwBsAG8AcgAgAD0AIAAoAEMAbwBsAG8AcgBYACoATgBvAHIAbQBhAGwAcwAuAHgAKQArACgAQwBvAGwAbwByAFkAKgBOAG8AcgBtAGEAbABzAC4AeQApACsAKABDAG8AbABvAHIAWgAqAE4AbwByAG0AYQBsAHMALgB6ACkAOwAKAAoAcgBlAHQAdQByAG4AIABvAHUAdABDAG8AbABvAHIAOwA=,output:2,fname:gfjhsg,width:609,height:170,input:12,input:2,input:2,input_1_label:Tex1,input_2_label:Normals,input_3_label:WorldPos|A-2892-TEX,B-4198-OUT,C-9763-OUT;n:type:ShaderForge.SFN_Code,id:8447,x:31875,y:36341,varname:node_8447,prsc:2,code:ZgBsAG8AYQB0ADQAIABDAG8AbABvAHIAWAAgAD0AIAB0AGUAeAAyAEQAKABUAGUAeAAxACwAIABXAG8AcgBsAGQAUABvAHMALgB5AHoAKQA7AAoAZgBsAG8AYQB0ADQAIABDAG8AbABvAHIAWQAgAD0AIAB0AGUAeAAyAEQAKABUAGUAeAAxACwAIABXAG8AcgBsAGQAUABvAHMALgB4AHoAKQA7AAoAZgBsAG8AYQB0ADQAIABDAG8AbABvAHIAWgAgAD0AIAB0AGUAeAAyAEQAKABUAGUAeAAxACwAIABXAG8AcgBsAGQAUABvAHMALgB4AHkAKQA7AAoACgBmAGwAbwBhAHQANAAgAG8AdQB0AEMAbwBsAG8AcgAgAD0AIAAoAEMAbwBsAG8AcgBYACoATgBvAHIAbQBhAGwAcwAuAHgAKQArACgAQwBvAGwAbwByAFkAKgBOAG8AcgBtAGEAbABzAC4AeQApACsAKABDAG8AbABvAHIAWgAqAE4AbwByAG0AYQBsAHMALgB6ACkAOwAKAAoAcgBlAHQAdQByAG4AIABvAHUAdABDAG8AbABvAHIAOwA=,output:3,fname:wet,width:609,height:170,input:12,input:2,input:2,input_1_label:Tex1,input_2_label:Normals,input_3_label:WorldPos|A-8229-TEX,B-4198-OUT,C-9763-OUT;n:type:ShaderForge.SFN_Code,id:7946,x:31869,y:36666,varname:node_7946,prsc:2,code:ZgBsAG8AYQB0ADMAIABDAG8AbABvAHIAWAAgAD0AIAB4ADsACgBmAGwAbwBhAHQAMwAgAEMAbwBsAG8AcgBZACAAPQAgAHkAOwAKAGYAbABvAGEAdAAzACAAQwBvAGwAbwByAFoAIAA9ACAAegA7AAoACgBmAGwAbwBhAHQAMwAgAG8AdQB0AEMAbwBsAG8AcgAgAD0AIAAoAEMAbwBsAG8AcgBYACoATgBvAHIAbQBhAGwAcwAuAHgAKQArACgAQwBvAGwAbwByAFkAKgBOAG8AcgBtAGEAbABzAC4AeQApACsAKABDAG8AbABvAHIAWgAqAE4AbwByAG0AYQBsAHMALgB6ACkAOwAKAAoAcgBlAHQAdQByAG4AIABvAHUAdABDAG8AbABvAHIAOwA=,output:2,fname:jtasdc,width:597,height:189,input:2,input:2,input:2,input:2,input_1_label:x,input_2_label:y,input_3_label:z,input_4_label:Normals|A-5544-RGB,B-4855-RGB,C-1581-RGB,D-4198-OUT;n:type:ShaderForge.SFN_Tex2d,id:5544,x:31537,y:36584,varname:node_5544,prsc:2,ntxv:0,isnm:False|UVIN-3416-OUT,TEX-7842-TEX;n:type:ShaderForge.SFN_Tex2d,id:4855,x:31537,y:36760,varname:node_4855,prsc:2,ntxv:0,isnm:False|UVIN-7335-OUT,TEX-7842-TEX;n:type:ShaderForge.SFN_Tex2d,id:1581,x:31537,y:36953,varname:node_1581,prsc:2,ntxv:0,isnm:False|UVIN-8885-OUT,TEX-7842-TEX;n:type:ShaderForge.SFN_Append,id:3416,x:31249,y:36596,varname:node_3416,prsc:2|A-1600-G,B-1600-B;n:type:ShaderForge.SFN_Append,id:7335,x:31261,y:36747,varname:node_7335,prsc:2|A-1600-R,B-1600-B;n:type:ShaderForge.SFN_Append,id:8885,x:31261,y:36902,varname:node_8885,prsc:2|A-1600-R,B-1600-G;n:type:ShaderForge.SFN_Multiply,id:9763,x:30531,y:36274,varname:node_9763,prsc:2|A-4574-OUT,B-9764-OUT;n:type:ShaderForge.SFN_ComponentMask,id:1600,x:31082,y:36747,varname:node_1600,prsc:2,cc1:0,cc2:0,cc3:0,cc4:-1|IN-9763-OUT;n:type:ShaderForge.SFN_ValueProperty,id:9764,x:30347,y:36336,ptovrint:False,ptlb:Detail Scale,ptin:_DetailScale,varname:node_9764,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:10;n:type:ShaderForge.SFN_Blend,id:5885,x:32761,y:35866,varname:node_5885,prsc:2,blmd:10,clmp:True|SRC-8573-OUT,DST-1958-OUT;n:type:ShaderForge.SFN_Blend,id:1986,x:32732,y:36157,varname:node_1986,prsc:2,blmd:10,clmp:True|SRC-5995-OUT,DST-8447-OUT;n:type:ShaderForge.SFN_Slider,id:2312,x:33131,y:35492,ptovrint:False,ptlb:gloss,ptin:_gloss,varname:node_2312,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.5,max:1;n:type:ShaderForge.SFN_Multiply,id:2719,x:33527,y:35331,varname:node_2719,prsc:2|A-9760-G,B-2312-OUT;n:type:ShaderForge.SFN_Transform,id:6360,x:29879,y:35688,varname:node_6360,prsc:2,tffrom:0,tfto:1|IN-4597-XYZ;n:type:ShaderForge.SFN_Frac,id:8827,x:33425,y:35669,varname:node_8827,prsc:2|IN-6869-OUT;n:type:ShaderForge.SFN_Lerp,id:4574,x:30146,y:35492,varname:node_4574,prsc:2|A-4597-XYZ,B-2126-OUT,T-5366-OUT;n:type:ShaderForge.SFN_ToggleProperty,id:5366,x:29776,y:35499,ptovrint:False,ptlb:objectspace,ptin:_objectspace,varname:node_5366,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False;n:type:ShaderForge.SFN_Lerp,id:5279,x:30516,y:35197,varname:node_5279,prsc:2|A-9412-OUT,B-3545-OUT,T-5366-OUT;n:type:ShaderForge.SFN_Transform,id:386,x:30001,y:34817,varname:node_386,prsc:2,tffrom:0,tfto:1|IN-9412-OUT;n:type:ShaderForge.SFN_Code,id:3545,x:29628,y:35151,varname:node_3545,prsc:2,code:cgBlAHQAdQByAG4AIABhAGIAcwAoAG0AdQBsACgAXwBXAG8AcgBsAGQAMgBPAGIAagBlAGMAdAAsACAAZgBsAG8AYQB0ADQAKABOAG8AcgBtAGEAbABEAGkAcgBlAGMAdABpAG8AbgAsADAAKQApAC4AeAB5AHoALgByAGcAYgApADsACgA=,output:2,fname:Function_node_3545,width:634,height:190,input:2,input_1_label:NormalDirection|A-9412-OUT;n:type:ShaderForge.SFN_Code,id:2126,x:29603,y:35908,varname:node_2126,prsc:2,code:cgBlAHQAdQByAG4AIABtAHUAbAAoAF8AVwBvAHIAbABkADIATwBiAGoAZQBjAHQALAAgAGYAbABvAGEAdAA0ACgAKABXAG8AcgBsAGQAUABvAHMAaQB0AGkAbwBuAC4AcgBnAGIALQBPAGIAagBlAGMAdABQAG8AcwBpAHQAaQBvAG4ALgByAGcAYgApACwAMAApAC4AcgBnAGIAKQA7AA==,output:2,fname:Function_node_2126,width:680,height:249,input:2,input:2,input_1_label:WorldPosition,input_2_label:ObjectPosition|A-4597-XYZ,B-2592-XYZ;n:type:ShaderForge.SFN_ObjectPosition,id:2592,x:29311,y:35939,varname:node_2592,prsc:2;n:type:ShaderForge.SFN_Multiply,id:839,x:30610,y:35747,varname:node_839,prsc:2|A-1166-OUT,B-5910-OUT;n:type:ShaderForge.SFN_ObjectScale,id:4694,x:30293,y:36078,varname:node_4694,prsc:2,rcp:False;n:type:ShaderForge.SFN_Lerp,id:5910,x:30602,y:35945,varname:node_5910,prsc:2|A-3894-OUT,B-4694-X,T-5366-OUT;n:type:ShaderForge.SFN_Vector1,id:3894,x:30380,y:35958,varname:node_3894,prsc:2,v1:1;proporder:2892-8229-7842-1166-1674-9764-2312-5366;pass:END;sub:END;*/

Shader "HUB/EnvMapping" {
    Properties {
        _Albedo1 ("Albedo 1", 2D) = "white" {}
        _Metallic1 ("Metallic 1", 2D) = "black" {}
        _Normals1 ("Normals 1", 2D) = "bump" {}
        _scale ("scale", Float ) = 1
        _Color ("Color", Color) = (1,1,1,1)
        _DetailScale ("Detail Scale", Float ) = 10
        _gloss ("gloss", Range(0, 1)) = 0.5
        [MaterialToggle] _objectspace ("objectspace", Float ) = 0
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _Albedo1; uniform float4 _Albedo1_ST;
            uniform sampler2D _Metallic1; uniform float4 _Metallic1_ST;
            uniform sampler2D _Normals1; uniform float4 _Normals1_ST;
            uniform float _scale;
            float3 Function_node_4457( sampler2D Tex1 , float3 Normals , float3 WorldPos ){
            float3 ColorX = tex2D(Tex1, WorldPos.yz);
            float3 ColorY = tex2D(Tex1, WorldPos.xz);
            float3 ColorZ = tex2D(Tex1, WorldPos.xy);
            
            float3 outColor = (ColorX*Normals.x)+(ColorY*Normals.y)+(ColorZ*Normals.z);
            
            return outColor;
            }
            
            float4 dfudsu( sampler2D Tex1 , float3 Normals , float3 WorldPos ){
            float4 ColorX = tex2D(Tex1, WorldPos.yz);
            float4 ColorY = tex2D(Tex1, WorldPos.xz);
            float4 ColorZ = tex2D(Tex1, WorldPos.xy);
            
            float4 outColor = (ColorX*Normals.x)+(ColorY*Normals.y)+(ColorZ*Normals.z);
            
            return outColor;
            }
            
            float3 sdfgr( float3 x , float3 y , float3 z , float3 Normals ){
            float3 ColorX = x;
            float3 ColorY = y;
            float3 ColorZ = z;
            
            float3 outColor = (ColorX*Normals.x)+(ColorY*Normals.y)+(ColorZ*Normals.z);
            
            return outColor;
            }
            
            uniform float4 _Color;
            uniform float _gloss;
            uniform fixed _objectspace;
            float3 Function_node_3545( float3 NormalDirection ){
            return abs(mul(unity_WorldToObject, float4(NormalDirection,0)).xyz.rgb);
            
            }
            
            float3 Function_node_2126( float3 WorldPosition , float3 ObjectPosition ){
            return mul(unity_WorldToObject, float4((WorldPosition.rgb-ObjectPosition.rgb),0).rgb);
            }
            
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv1 : TEXCOORD0;
                float2 uv2 : TEXCOORD1;
                float4 posWorld : TEXCOORD2;
                float3 normalDir : TEXCOORD3;
                float3 tangentDir : TEXCOORD4;
                float3 bitangentDir : TEXCOORD5;
                LIGHTING_COORDS(6,7)
                UNITY_FOG_COORDS(8)
                #if defined(LIGHTMAP_ON) || defined(UNITY_SHOULD_SAMPLE_SH)
                    float4 ambientOrLightmapUV : TEXCOORD9;
                #endif
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                #ifdef LIGHTMAP_ON
                    o.ambientOrLightmapUV.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
                    o.ambientOrLightmapUV.zw = 0;
                #elif UNITY_SHOULD_SAMPLE_SH
                #endif
                #ifdef DYNAMICLIGHTMAP_ON
                    o.ambientOrLightmapUV.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
                #endif
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                float3 recipObjScale = float3( length(unity_WorldToObject[0].xyz), length(unity_WorldToObject[1].xyz), length(unity_WorldToObject[2].xyz) );
                float3 objScale = 1.0/recipObjScale;
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                float3 recipObjScale = float3( length(unity_WorldToObject[0].xyz), length(unity_WorldToObject[1].xyz), length(unity_WorldToObject[2].xyz) );
                float3 objScale = 1.0/recipObjScale;
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 node_4574 = lerp(i.posWorld.rgb,Function_node_2126( i.posWorld.rgb , objPos.rgb ),_objectspace);
                float3 node_6869 = (node_4574*(_scale*lerp(1.0,objScale.r,_objectspace)));
                float3 node_5382 = node_6869.rrr;
                float2 node_4518 = float2(node_5382.g,node_5382.b);
                float3 node_3288 = UnpackNormal(tex2D(_Normals1,TRANSFORM_TEX(node_4518, _Normals1)));
                float2 node_6253 = float2(node_5382.r,node_5382.b);
                float3 node_8570 = UnpackNormal(tex2D(_Normals1,TRANSFORM_TEX(node_6253, _Normals1)));
                float2 node_328 = float2(node_5382.r,node_5382.g);
                float3 node_9700 = UnpackNormal(tex2D(_Normals1,TRANSFORM_TEX(node_328, _Normals1)));
                float3 node_5279 = lerp(i.normalDir,Function_node_3545( i.normalDir ),_objectspace);
                float3 node_4198 = (node_5279*node_5279);
                float3 normalLocal = sdfgr( node_3288.rgb , node_8570.rgb , node_9700.rgb , node_4198 );
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
///////// Gloss:
                float4 node_5995 = dfudsu( _Metallic1 , node_4198 , node_6869 );
                float2 node_9760 = node_5995.ra;
                float gloss = (node_9760.g*_gloss);
                float perceptualRoughness = 1.0 - (node_9760.g*_gloss);
                float roughness = perceptualRoughness * perceptualRoughness;
                float specPow = exp2( gloss * 10.0 + 1.0 );
/////// GI Data:
                UnityLight light;
                #ifdef LIGHTMAP_OFF
                    light.color = lightColor;
                    light.dir = lightDirection;
                    light.ndotl = LambertTerm (normalDirection, light.dir);
                #else
                    light.color = half3(0.f, 0.f, 0.f);
                    light.ndotl = 0.0f;
                    light.dir = half3(0.f, 0.f, 0.f);
                #endif
                UnityGIInput d;
                d.light = light;
                d.worldPos = i.posWorld.xyz;
                d.worldViewDir = viewDirection;
                d.atten = attenuation;
                #if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
                    d.ambient = 0;
                    d.lightmapUV = i.ambientOrLightmapUV;
                #else
                    d.ambient = i.ambientOrLightmapUV;
                #endif
                #if UNITY_SPECCUBE_BLENDING || UNITY_SPECCUBE_BOX_PROJECTION
                    d.boxMin[0] = unity_SpecCube0_BoxMin;
                    d.boxMin[1] = unity_SpecCube1_BoxMin;
                #endif
                #if UNITY_SPECCUBE_BOX_PROJECTION
                    d.boxMax[0] = unity_SpecCube0_BoxMax;
                    d.boxMax[1] = unity_SpecCube1_BoxMax;
                    d.probePosition[0] = unity_SpecCube0_ProbePosition;
                    d.probePosition[1] = unity_SpecCube1_ProbePosition;
                #endif
                d.probeHDR[0] = unity_SpecCube0_HDR;
                d.probeHDR[1] = unity_SpecCube1_HDR;
                Unity_GlossyEnvironmentData ugls_en_data;
                ugls_en_data.roughness = 1.0 - gloss;
                ugls_en_data.reflUVW = viewReflectDirection;
                UnityGI gi = UnityGlobalIllumination(d, 1, normalDirection, ugls_en_data );
                lightDirection = gi.light.dir;
                lightColor = gi.light.color;
////// Specular:
                float NdotL = saturate(dot( normalDirection, lightDirection ));
                float LdotH = saturate(dot(lightDirection, halfDirection));
                float3 specularColor = node_9760.r;
                float specularMonochrome;
                float3 node_8573 = (_Color.rgb*Function_node_4457( _Albedo1 , node_4198 , node_6869 ));
                float3 diffuseColor = node_8573; // Need this for specular when using metallic
                diffuseColor = DiffuseAndSpecularFromMetallic( diffuseColor, specularColor, specularColor, specularMonochrome );
                specularMonochrome = 1.0-specularMonochrome;
                float NdotV = abs(dot( normalDirection, viewDirection ));
                float NdotH = saturate(dot( normalDirection, halfDirection ));
                float VdotH = saturate(dot( viewDirection, halfDirection ));
                float visTerm = SmithJointGGXVisibilityTerm( NdotL, NdotV, roughness );
                float normTerm = GGXTerm(NdotH, roughness);
                float specularPBL = (visTerm*normTerm) * UNITY_PI;
                #ifdef UNITY_COLORSPACE_GAMMA
                    specularPBL = sqrt(max(1e-4h, specularPBL));
                #endif
                specularPBL = max(0, specularPBL * NdotL);
                #if defined(_SPECULARHIGHLIGHTS_OFF)
                    specularPBL = 0.0;
                #endif
                half surfaceReduction;
                #ifdef UNITY_COLORSPACE_GAMMA
                    surfaceReduction = 1.0-0.28*roughness*perceptualRoughness;
                #else
                    surfaceReduction = 1.0/(roughness*roughness + 1.0);
                #endif
                specularPBL *= any(specularColor) ? 1.0 : 0.0;
                float3 directSpecular = attenColor*specularPBL*FresnelTerm(specularColor, LdotH);
                half grazingTerm = saturate( gloss + specularMonochrome );
                float3 indirectSpecular = (gi.indirect.specular);
                indirectSpecular *= FresnelLerp (specularColor, grazingTerm, NdotV);
                indirectSpecular *= surfaceReduction;
                float3 specular = (directSpecular + indirectSpecular);
/////// Diffuse:
                NdotL = max(0.0,dot( normalDirection, lightDirection ));
                half fd90 = 0.5 + 2 * LdotH * LdotH * (1-gloss);
                float nlPow5 = Pow5(1-NdotL);
                float nvPow5 = Pow5(1-NdotV);
                float3 directDiffuse = ((1 +(fd90 - 1)*nlPow5) * (1 + (fd90 - 1)*nvPow5) * NdotL) * attenColor;
                float3 indirectDiffuse = float3(0,0,0);
                indirectDiffuse += gi.indirect.diffuse;
                float3 diffuse = (directDiffuse + indirectDiffuse) * diffuseColor;
/// Final Color:
                float3 finalColor = diffuse + specular;
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDADD
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _Albedo1; uniform float4 _Albedo1_ST;
            uniform sampler2D _Metallic1; uniform float4 _Metallic1_ST;
            uniform sampler2D _Normals1; uniform float4 _Normals1_ST;
            uniform float _scale;
            float3 Function_node_4457( sampler2D Tex1 , float3 Normals , float3 WorldPos ){
            float3 ColorX = tex2D(Tex1, WorldPos.yz);
            float3 ColorY = tex2D(Tex1, WorldPos.xz);
            float3 ColorZ = tex2D(Tex1, WorldPos.xy);
            
            float3 outColor = (ColorX*Normals.x)+(ColorY*Normals.y)+(ColorZ*Normals.z);
            
            return outColor;
            }
            
            float4 dfudsu( sampler2D Tex1 , float3 Normals , float3 WorldPos ){
            float4 ColorX = tex2D(Tex1, WorldPos.yz);
            float4 ColorY = tex2D(Tex1, WorldPos.xz);
            float4 ColorZ = tex2D(Tex1, WorldPos.xy);
            
            float4 outColor = (ColorX*Normals.x)+(ColorY*Normals.y)+(ColorZ*Normals.z);
            
            return outColor;
            }
            
            float3 sdfgr( float3 x , float3 y , float3 z , float3 Normals ){
            float3 ColorX = x;
            float3 ColorY = y;
            float3 ColorZ = z;
            
            float3 outColor = (ColorX*Normals.x)+(ColorY*Normals.y)+(ColorZ*Normals.z);
            
            return outColor;
            }
            
            uniform float4 _Color;
            uniform float _gloss;
            uniform fixed _objectspace;
            float3 Function_node_3545( float3 NormalDirection ){
            return abs(mul(unity_WorldToObject, float4(NormalDirection,0)).xyz.rgb);
            
            }
            
            float3 Function_node_2126( float3 WorldPosition , float3 ObjectPosition ){
            return mul(unity_WorldToObject, float4((WorldPosition.rgb-ObjectPosition.rgb),0).rgb);
            }
            
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv1 : TEXCOORD0;
                float2 uv2 : TEXCOORD1;
                float4 posWorld : TEXCOORD2;
                float3 normalDir : TEXCOORD3;
                float3 tangentDir : TEXCOORD4;
                float3 bitangentDir : TEXCOORD5;
                LIGHTING_COORDS(6,7)
                UNITY_FOG_COORDS(8)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                float3 recipObjScale = float3( length(unity_WorldToObject[0].xyz), length(unity_WorldToObject[1].xyz), length(unity_WorldToObject[2].xyz) );
                float3 objScale = 1.0/recipObjScale;
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                float3 recipObjScale = float3( length(unity_WorldToObject[0].xyz), length(unity_WorldToObject[1].xyz), length(unity_WorldToObject[2].xyz) );
                float3 objScale = 1.0/recipObjScale;
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 node_4574 = lerp(i.posWorld.rgb,Function_node_2126( i.posWorld.rgb , objPos.rgb ),_objectspace);
                float3 node_6869 = (node_4574*(_scale*lerp(1.0,objScale.r,_objectspace)));
                float3 node_5382 = node_6869.rrr;
                float2 node_4518 = float2(node_5382.g,node_5382.b);
                float3 node_3288 = UnpackNormal(tex2D(_Normals1,TRANSFORM_TEX(node_4518, _Normals1)));
                float2 node_6253 = float2(node_5382.r,node_5382.b);
                float3 node_8570 = UnpackNormal(tex2D(_Normals1,TRANSFORM_TEX(node_6253, _Normals1)));
                float2 node_328 = float2(node_5382.r,node_5382.g);
                float3 node_9700 = UnpackNormal(tex2D(_Normals1,TRANSFORM_TEX(node_328, _Normals1)));
                float3 node_5279 = lerp(i.normalDir,Function_node_3545( i.normalDir ),_objectspace);
                float3 node_4198 = (node_5279*node_5279);
                float3 normalLocal = sdfgr( node_3288.rgb , node_8570.rgb , node_9700.rgb , node_4198 );
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
///////// Gloss:
                float4 node_5995 = dfudsu( _Metallic1 , node_4198 , node_6869 );
                float2 node_9760 = node_5995.ra;
                float gloss = (node_9760.g*_gloss);
                float perceptualRoughness = 1.0 - (node_9760.g*_gloss);
                float roughness = perceptualRoughness * perceptualRoughness;
                float specPow = exp2( gloss * 10.0 + 1.0 );
////// Specular:
                float NdotL = saturate(dot( normalDirection, lightDirection ));
                float LdotH = saturate(dot(lightDirection, halfDirection));
                float3 specularColor = node_9760.r;
                float specularMonochrome;
                float3 node_8573 = (_Color.rgb*Function_node_4457( _Albedo1 , node_4198 , node_6869 ));
                float3 diffuseColor = node_8573; // Need this for specular when using metallic
                diffuseColor = DiffuseAndSpecularFromMetallic( diffuseColor, specularColor, specularColor, specularMonochrome );
                specularMonochrome = 1.0-specularMonochrome;
                float NdotV = abs(dot( normalDirection, viewDirection ));
                float NdotH = saturate(dot( normalDirection, halfDirection ));
                float VdotH = saturate(dot( viewDirection, halfDirection ));
                float visTerm = SmithJointGGXVisibilityTerm( NdotL, NdotV, roughness );
                float normTerm = GGXTerm(NdotH, roughness);
                float specularPBL = (visTerm*normTerm) * UNITY_PI;
                #ifdef UNITY_COLORSPACE_GAMMA
                    specularPBL = sqrt(max(1e-4h, specularPBL));
                #endif
                specularPBL = max(0, specularPBL * NdotL);
                #if defined(_SPECULARHIGHLIGHTS_OFF)
                    specularPBL = 0.0;
                #endif
                specularPBL *= any(specularColor) ? 1.0 : 0.0;
                float3 directSpecular = attenColor*specularPBL*FresnelTerm(specularColor, LdotH);
                float3 specular = directSpecular;
/////// Diffuse:
                NdotL = max(0.0,dot( normalDirection, lightDirection ));
                half fd90 = 0.5 + 2 * LdotH * LdotH * (1-gloss);
                float nlPow5 = Pow5(1-NdotL);
                float nvPow5 = Pow5(1-NdotV);
                float3 directDiffuse = ((1 +(fd90 - 1)*nlPow5) * (1 + (fd90 - 1)*nvPow5) * NdotL) * attenColor;
                float3 diffuse = directDiffuse * diffuseColor;
/// Final Color:
                float3 finalColor = diffuse + specular;
                fixed4 finalRGBA = fixed4(finalColor * 1,0);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "Meta"
            Tags {
                "LightMode"="Meta"
            }
            Cull Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_META 1
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #include "UnityMetaPass.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _Albedo1; uniform float4 _Albedo1_ST;
            uniform sampler2D _Metallic1; uniform float4 _Metallic1_ST;
            uniform float _scale;
            float3 Function_node_4457( sampler2D Tex1 , float3 Normals , float3 WorldPos ){
            float3 ColorX = tex2D(Tex1, WorldPos.yz);
            float3 ColorY = tex2D(Tex1, WorldPos.xz);
            float3 ColorZ = tex2D(Tex1, WorldPos.xy);
            
            float3 outColor = (ColorX*Normals.x)+(ColorY*Normals.y)+(ColorZ*Normals.z);
            
            return outColor;
            }
            
            float4 dfudsu( sampler2D Tex1 , float3 Normals , float3 WorldPos ){
            float4 ColorX = tex2D(Tex1, WorldPos.yz);
            float4 ColorY = tex2D(Tex1, WorldPos.xz);
            float4 ColorZ = tex2D(Tex1, WorldPos.xy);
            
            float4 outColor = (ColorX*Normals.x)+(ColorY*Normals.y)+(ColorZ*Normals.z);
            
            return outColor;
            }
            
            uniform float4 _Color;
            uniform float _gloss;
            uniform fixed _objectspace;
            float3 Function_node_3545( float3 NormalDirection ){
            return abs(mul(unity_WorldToObject, float4(NormalDirection,0)).xyz.rgb);
            
            }
            
            float3 Function_node_2126( float3 WorldPosition , float3 ObjectPosition ){
            return mul(unity_WorldToObject, float4((WorldPosition.rgb-ObjectPosition.rgb),0).rgb);
            }
            
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv1 : TEXCOORD0;
                float2 uv2 : TEXCOORD1;
                float4 posWorld : TEXCOORD2;
                float3 normalDir : TEXCOORD3;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                float3 recipObjScale = float3( length(unity_WorldToObject[0].xyz), length(unity_WorldToObject[1].xyz), length(unity_WorldToObject[2].xyz) );
                float3 objScale = 1.0/recipObjScale;
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityMetaVertexPosition(v.vertex, v.texcoord1.xy, v.texcoord2.xy, unity_LightmapST, unity_DynamicLightmapST );
                return o;
            }
            float4 frag(VertexOutput i) : SV_Target {
                float4 objPos = mul ( unity_ObjectToWorld, float4(0,0,0,1) );
                float3 recipObjScale = float3( length(unity_WorldToObject[0].xyz), length(unity_WorldToObject[1].xyz), length(unity_WorldToObject[2].xyz) );
                float3 objScale = 1.0/recipObjScale;
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                UnityMetaInput o;
                UNITY_INITIALIZE_OUTPUT( UnityMetaInput, o );
                
                o.Emission = 0;
                
                float3 node_5279 = lerp(i.normalDir,Function_node_3545( i.normalDir ),_objectspace);
                float3 node_4198 = (node_5279*node_5279);
                float3 node_4574 = lerp(i.posWorld.rgb,Function_node_2126( i.posWorld.rgb , objPos.rgb ),_objectspace);
                float3 node_6869 = (node_4574*(_scale*lerp(1.0,objScale.r,_objectspace)));
                float3 node_8573 = (_Color.rgb*Function_node_4457( _Albedo1 , node_4198 , node_6869 ));
                float3 diffColor = node_8573;
                float specularMonochrome;
                float3 specColor;
                float4 node_5995 = dfudsu( _Metallic1 , node_4198 , node_6869 );
                float2 node_9760 = node_5995.ra;
                diffColor = DiffuseAndSpecularFromMetallic( diffColor, node_9760.r, specColor, specularMonochrome );
                float roughness = 1.0 - (node_9760.g*_gloss);
                o.Albedo = diffColor + specColor * roughness * roughness * 0.5;
                
                return UnityMetaFragment( o );
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
