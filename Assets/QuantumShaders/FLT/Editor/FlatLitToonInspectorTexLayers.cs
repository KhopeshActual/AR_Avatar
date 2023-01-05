using UnityEditor;
using UnityEngine;
using System.Collections.Generic;
using System.Linq;
using System;

public class FlatLitToonInspectorTexLayers : ShaderGUI
{
    public enum StarLayers
    {
        Single,
        Double,
        Triple
    }

    public enum Coloring
    {
        Static,
        Colors,
        Rainbow
    }

    public enum OutlineMode
    {
        None,
        Tinted,
        Colored
    }

    public enum BlendMode
    {
        Opaque,
        Cutout,
        Fade,   // Old school alpha-blending mode, fresnel does not affect amount of transparency
        Transparent // Physically plausible transparency mode, implemented as alpha pre-multiply
    }

    MaterialProperty blendMode;
    MaterialProperty mainTexture;
    MaterialProperty color;
    MaterialProperty colorMask;
    MaterialProperty shadow;
    MaterialProperty outlineMode;
    MaterialProperty starLayers;
    MaterialProperty outlineWidth;
    MaterialProperty outlineColor;
    MaterialProperty emissionMap;
    MaterialProperty emissionColor;
    MaterialProperty normalMap;
    MaterialProperty alphaCutoff;

    MaterialProperty individ_colors;
    MaterialProperty effect_mask;
    MaterialProperty hearts_angle;
    //StarLayer1
    MaterialProperty stars1_size;
    MaterialProperty stars1_speed;
    MaterialProperty stars1_rainbow;
    MaterialProperty stars1_rb_speed;
    MaterialProperty stars1_uniform;
    MaterialProperty stars1_offset;
    MaterialProperty stars1_c1;
    MaterialProperty stars1_c2;
    MaterialProperty stars1_c3;
    MaterialProperty stars1_tex;
    //StarLayer2
    MaterialProperty stars2_size;
    MaterialProperty stars2_speed;
    MaterialProperty stars2_rainbow;
    MaterialProperty stars2_rb_speed;
    MaterialProperty stars2_uniform;
    MaterialProperty stars2_offset;
    MaterialProperty stars2_c1;
    MaterialProperty stars2_c2;
    MaterialProperty stars2_c3;
    MaterialProperty stars2_tex;
    //StarLayer3
    MaterialProperty stars3_size;
    MaterialProperty stars3_speed;
    MaterialProperty stars3_rainbow;
    MaterialProperty stars3_rb_speed;
    MaterialProperty stars3_uniform;
    MaterialProperty stars3_offset;
    MaterialProperty stars3_c1;
    MaterialProperty stars3_c2;
    MaterialProperty stars3_c3;
    MaterialProperty stars3_tex;

    public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] props)
    {
        { //Find Properties
            blendMode = FindProperty("_Mode", props);
            mainTexture = FindProperty("_MainTex", props);
            color = FindProperty("_Color", props);
            colorMask = FindProperty("_ColorMask", props);
            shadow = FindProperty("_Shadow", props);
            outlineMode = FindProperty("_OutlineMode", props);
            starLayers = FindProperty("_StarLayers", props);
            outlineWidth = FindProperty("_outline_width", props);
            outlineColor = FindProperty("_outline_color", props);
            emissionMap = FindProperty("_EmissionMap", props);
            emissionColor = FindProperty("_EmissionColor", props);
            normalMap = FindProperty("_BumpMap", props);
            alphaCutoff = FindProperty("_Cutoff", props);

            effect_mask = FindProperty("_EffectMask", props);
            individ_colors = FindProperty("_IndividualColors", props);
            hearts_angle = FindProperty("_hearts_angle", props);
            //StarLayer1
            stars1_size = FindProperty("_stars1_size", props);
            stars1_speed = FindProperty("_stars1_speed", props);
            stars1_rainbow = FindProperty("_stars1_rainbow", props);
            stars1_rb_speed = FindProperty("_stars1_rb_speed", props);
            stars1_uniform = FindProperty("_stars1_uniform", props);
            stars1_offset = FindProperty("_stars1_offset", props);
            stars1_c1 = FindProperty("_stars1_c1", props);
            stars1_c2 = FindProperty("_stars1_c2", props);
            stars1_c3 = FindProperty("_stars1_c3", props);
            stars1_tex = FindProperty("_stars1_tex", props);
            //StarLayer1
            stars2_size = FindProperty("_stars2_size", props);
            stars2_speed = FindProperty("_stars2_speed", props);
            stars2_rainbow = FindProperty("_stars2_rainbow", props);
            stars2_rb_speed = FindProperty("_stars2_rb_speed", props);
            stars2_uniform = FindProperty("_stars2_uniform", props);
            stars2_offset = FindProperty("_stars2_offset", props);
            stars2_c1 = FindProperty("_stars2_c1", props);
            stars2_c2 = FindProperty("_stars2_c2", props);
            stars2_c3 = FindProperty("_stars2_c3", props);
            stars2_tex = FindProperty("_stars2_tex", props);
            //StarLayer1
            stars3_size = FindProperty("_stars3_size", props);
            stars3_speed = FindProperty("_stars3_speed", props);
            stars3_rainbow = FindProperty("_stars3_rainbow", props);
            stars3_rb_speed = FindProperty("_stars3_rb_speed", props);
            stars3_uniform = FindProperty("_stars3_uniform", props);
            stars3_offset = FindProperty("_stars3_offset", props);
            stars3_c1 = FindProperty("_stars3_c1", props);
            stars3_c2 = FindProperty("_stars3_c2", props);
            stars3_c3 = FindProperty("_stars3_c3", props);
            stars3_tex = FindProperty("_stars3_tex", props);
        }

        Material material = materialEditor.target as Material;

        { //Shader Properties GUI
            EditorGUIUtility.labelWidth = 0f;

            EditorGUI.BeginChangeCheck();
            {
                EditorGUI.showMixedValue = blendMode.hasMixedValue;
                var bMode = (BlendMode)blendMode.floatValue;

                EditorGUI.BeginChangeCheck();
                bMode = (BlendMode)EditorGUILayout.Popup("Rendering Mode", (int)bMode, Enum.GetNames(typeof(BlendMode)));
                if (EditorGUI.EndChangeCheck()){
                    materialEditor.RegisterPropertyChangeUndo("Rendering Mode");
                    blendMode.floatValue = (float)bMode;

                    foreach (var obj in blendMode.targets){
                        SetupMaterialWithBlendMode((Material)obj, (BlendMode)material.GetFloat("_Mode"));
                    }
                }

                EditorGUI.showMixedValue = false;


                materialEditor.TexturePropertySingleLine(new GUIContent("Main Texture", "Main Color Texture (RGB)"), mainTexture, color);
                EditorGUI.indentLevel += 2;
                if((BlendMode)material.GetFloat("_Mode") == BlendMode.Cutout)
                    materialEditor.ShaderProperty(alphaCutoff, "Alpha Cutoff", 2);
                materialEditor.TexturePropertySingleLine(new GUIContent("Color Mask", "Masks Color Tinting (G)"), colorMask);
                EditorGUI.indentLevel -= 2;
                materialEditor.TexturePropertySingleLine(new GUIContent("Normal Map", "Normal Map (RGB)"), normalMap);
                materialEditor.TexturePropertySingleLine(new GUIContent("Emission", "Emission (RGB)"), emissionMap, emissionColor);
                EditorGUI.BeginChangeCheck();
                materialEditor.TextureScaleOffsetProperty(mainTexture);
                if (EditorGUI.EndChangeCheck())
                    emissionMap.textureScaleAndOffset = mainTexture.textureScaleAndOffset;

                EditorGUILayout.Space();
                materialEditor.ShaderProperty(shadow, "Shadow");

                var oMode = (OutlineMode)outlineMode.floatValue;

                EditorGUI.BeginChangeCheck();
                oMode = (OutlineMode)EditorGUILayout.Popup("Outline Mode", (int)oMode, Enum.GetNames(typeof(OutlineMode)));

                if (EditorGUI.EndChangeCheck()){
                    materialEditor.RegisterPropertyChangeUndo("Outline Mode");
                    outlineMode.floatValue = (float)oMode;

                    foreach (var obj in outlineMode.targets){
                        SetupMaterialWithOutlineMode((Material)obj, (OutlineMode)material.GetFloat("_OutlineMode"));
                    }

                }
                switch (oMode){
                    case OutlineMode.Tinted:
                    case OutlineMode.Colored:
                        materialEditor.ShaderProperty(outlineColor, "Color", 2);
                        materialEditor.ShaderProperty(outlineWidth, new GUIContent("Width", "Outline Width in cm"), 2);
                        break;
                    case OutlineMode.None:
                    default:
                        break;
                }
                {// <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< CUSTOM
                    GUILayout.Label("_____Heart_Settings_____", EditorStyles.boldLabel);

                    materialEditor.TexturePropertySingleLine(new GUIContent("Effect Mask", "Effect Mask"), effect_mask);

                    var stLayers = (StarLayers)starLayers.floatValue;

                    EditorGUI.BeginChangeCheck();
                    stLayers = (StarLayers)EditorGUILayout.Popup("Heart Layers", (int)stLayers, Enum.GetNames(typeof(StarLayers)));

                    if (EditorGUI.EndChangeCheck()){
                        materialEditor.RegisterPropertyChangeUndo("Heart Layers");
                        starLayers.floatValue = (float)stLayers;

                        foreach (var obj in starLayers.targets){
                            SetupMaterialWithStarLayers((Material)obj);
                        }
                    }

                    materialEditor.ShaderProperty(hearts_angle, "Hearts Angle");
                    materialEditor.ShaderProperty(individ_colors, "Individual Coloring");

                    bool indivColors = material.GetFloat("_IndividualColors") != 0.0;

                    if(!indivColors){
                        AddLayerSettings(materialEditor, 0, indivColors);
                        material.DisableKeyword("_UNIFORM_COLOR");
                    }else{
                        material.EnableKeyword("_UNIFORM_COLOR");
                    }

                    switch (stLayers){
                        case StarLayers.Single:
                            AddLayerSettings(materialEditor, 1, indivColors);
                            break;
                        case StarLayers.Double:
                            AddLayerSettings(materialEditor, 1, indivColors);
                            AddLayerSettings(materialEditor, 2, indivColors);
                            break;
                        case StarLayers.Triple:
                            AddLayerSettings(materialEditor, 1, indivColors);
                            AddLayerSettings(materialEditor, 2, indivColors);
                            AddLayerSettings(materialEditor, 3, indivColors);
                            break;
                        default:
                            break;
                    }
                }// <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< END
            }
            EditorGUI.EndChangeCheck();
        }
    }

    public void AddLayerSettings(MaterialEditor materialEditor, int layer, bool colorSetting){
        Material material = materialEditor.target as Material;
        switch (layer){
            case 0:
                GUILayout.Label("Coloring", EditorStyles.boldLabel);
                materialEditor.ShaderProperty(stars1_uniform, "Uniform Color");
                materialEditor.ShaderProperty(stars1_rainbow, "Rainbow Color");
                if(material.GetFloat("_stars1_rainbow") == 0.0){
                    materialEditor.ShaderProperty(stars1_c1, "Color1", 2);
                    materialEditor.ShaderProperty(stars1_c2, "Color2", 2);
                    materialEditor.ShaderProperty(stars1_c3, "Color3", 2);
                    material.DisableKeyword("_RAINBOW_L1");
                }else{
                    materialEditor.ShaderProperty(stars1_rb_speed, "Colorchange Speed", 2);
                    material.EnableKeyword("_RAINBOW_L1");
                }
                break;
            case 1:
                GUILayout.Label("First Layer", EditorStyles.boldLabel);
                materialEditor.TexturePropertySingleLine(new GUIContent("Texture", "Texture"), stars1_tex);
                materialEditor.ShaderProperty(stars1_offset, "Offset");
                materialEditor.ShaderProperty(stars1_size, "Size", 2);
                materialEditor.ShaderProperty(stars1_speed, "Speed", 2);
                if(colorSetting){
                    materialEditor.ShaderProperty(stars1_uniform, "Uniform Color");
                    materialEditor.ShaderProperty(stars1_rainbow, "Rainbow Color");
                    if(material.GetFloat("_stars1_rainbow") == 0.0){
                        materialEditor.ShaderProperty(stars1_c1, "Color1", 2);
                        materialEditor.ShaderProperty(stars1_c2, "Color2", 2);
                        materialEditor.ShaderProperty(stars1_c3, "Color3", 2);
                        material.DisableKeyword("_RAINBOW_L1");
                    }else{
                        materialEditor.ShaderProperty(stars1_rb_speed, "Colorchange Speed", 2);
                        material.EnableKeyword("_RAINBOW_L1");
                    }
                }
                break;
            case 2:
                GUILayout.Label("Second Layer", EditorStyles.boldLabel);
                materialEditor.TexturePropertySingleLine(new GUIContent("Texture", "Texture"), stars2_tex);
                materialEditor.ShaderProperty(stars2_offset, "Offset");
                materialEditor.ShaderProperty(stars2_size, "Size", 2);
                materialEditor.ShaderProperty(stars2_speed, "Speed", 2);
                if(colorSetting){
                    materialEditor.ShaderProperty(stars2_uniform, "Uniform Color");
                    materialEditor.ShaderProperty(stars2_rainbow, "Rainbow Color");
                    if(material.GetFloat("_stars2_rainbow") == 0.0){
                        materialEditor.ShaderProperty(stars2_c1, "Color1", 2);
                        materialEditor.ShaderProperty(stars2_c2, "Color2", 2);
                        materialEditor.ShaderProperty(stars2_c3, "Color3", 2);
                        material.DisableKeyword("_RAINBOW_L2");
                    }else{
                        materialEditor.ShaderProperty(stars2_rb_speed, "Colorchange Speed", 2);
                        material.EnableKeyword("_RAINBOW_L2");
                    }
                }
                break;
            case 3:
                GUILayout.Label("Third Layer", EditorStyles.boldLabel);
                materialEditor.TexturePropertySingleLine(new GUIContent("Texture", "Texture"), stars3_tex);
                materialEditor.ShaderProperty(stars3_offset, "Offset");
                materialEditor.ShaderProperty(stars3_size, "Size", 2);
                materialEditor.ShaderProperty(stars3_speed, "Speed", 2);
                if(colorSetting){
                    materialEditor.ShaderProperty(stars3_uniform, "Uniform Color");
                    materialEditor.ShaderProperty(stars3_rainbow, "Rainbow Color");
                    if(material.GetFloat("_stars3_rainbow") == 0.0){
                        materialEditor.ShaderProperty(stars3_c1, "Color1", 2);
                        materialEditor.ShaderProperty(stars3_c2, "Color2", 2);
                        materialEditor.ShaderProperty(stars3_c3, "Color3", 2);
                        material.DisableKeyword("_RAINBOW_L3");
                    }else{
                        materialEditor.ShaderProperty(stars3_rb_speed, "Colorchange Speed", 2);
                        material.EnableKeyword("_RAINBOW_L3");
                    }
                }
                break;
            default:
                break;
        }
    }

    public static void SetupMaterialWithBlendMode(Material material, BlendMode blendMode){
        switch ((BlendMode)material.GetFloat("_Mode")){
            case BlendMode.Opaque:
                material.SetOverrideTag("RenderType", "");
                material.SetInt("_SrcBlend", (int)UnityEngine.Rendering.BlendMode.One);
                material.SetInt("_DstBlend", (int)UnityEngine.Rendering.BlendMode.Zero);
                material.SetInt("_ZWrite", 1);
                material.DisableKeyword("_ALPHATEST_ON");
                material.DisableKeyword("_ALPHABLEND_ON");
                material.DisableKeyword("_ALPHAPREMULTIPLY_ON");
                material.renderQueue = -1;
                break;
            case BlendMode.Cutout:
                material.SetOverrideTag("RenderType", "TransparentCutout");
                material.SetInt("_SrcBlend", (int)UnityEngine.Rendering.BlendMode.One);
                material.SetInt("_DstBlend", (int)UnityEngine.Rendering.BlendMode.Zero);
                material.SetInt("_ZWrite", 1);
                material.EnableKeyword("_ALPHATEST_ON");
                material.DisableKeyword("_ALPHABLEND_ON");
                material.DisableKeyword("_ALPHAPREMULTIPLY_ON");
                material.renderQueue = (int)UnityEngine.Rendering.RenderQueue.AlphaTest;
                break;
            case BlendMode.Fade:
                material.SetOverrideTag("RenderType", "Transparent");
                material.SetInt("_SrcBlend", (int)UnityEngine.Rendering.BlendMode.SrcAlpha);
                material.SetInt("_DstBlend", (int)UnityEngine.Rendering.BlendMode.OneMinusSrcAlpha);
                material.SetInt("_ZWrite", 0);
                material.DisableKeyword("_ALPHATEST_ON");
                material.EnableKeyword("_ALPHABLEND_ON");
                material.DisableKeyword("_ALPHAPREMULTIPLY_ON");
                material.renderQueue = (int)UnityEngine.Rendering.RenderQueue.Transparent;
                break;
            case BlendMode.Transparent:
                material.SetOverrideTag("RenderType", "Transparent");
                material.SetInt("_SrcBlend", (int)UnityEngine.Rendering.BlendMode.One);
                material.SetInt("_DstBlend", (int)UnityEngine.Rendering.BlendMode.OneMinusSrcAlpha);
                material.SetInt("_ZWrite", 0);
                material.DisableKeyword("_ALPHATEST_ON");
                material.DisableKeyword("_ALPHABLEND_ON");
                material.EnableKeyword("_ALPHAPREMULTIPLY_ON");
                material.renderQueue = (int)UnityEngine.Rendering.RenderQueue.Transparent;
                break;
        }
    }

    public static void SetupMaterialWithOutlineMode(Material material, OutlineMode outlineMode){
        switch ((OutlineMode)material.GetFloat("_OutlineMode")){
            case OutlineMode.None:
                material.EnableKeyword("NO_OUTLINE");
                material.DisableKeyword("TINTED_OUTLINE");
                material.DisableKeyword("COLORED_OUTLINE");
                break;
            case OutlineMode.Tinted:
                material.DisableKeyword("NO_OUTLINE");
                material.EnableKeyword("TINTED_OUTLINE");
                material.DisableKeyword("COLORED_OUTLINE");
                break;
            case OutlineMode.Colored:
                material.DisableKeyword("NO_OUTLINE");
                material.DisableKeyword("TINTED_OUTLINE");
                material.EnableKeyword("COLORED_OUTLINE");
                break;
            default:
                break;
        }
    }

    public static void SetupMaterialWithStarLayers(Material material){
        switch ((StarLayers)material.GetFloat("_StarLayers")){
            case StarLayers.Single:
                material.SetInt("_StarLayers", 0);
                material.DisableKeyword("_SECOND_LAYER");
                material.DisableKeyword("_THIRD_LAYER");
                break;
            case StarLayers.Double:
                material.SetInt("_StarLayers", 1);
                material.EnableKeyword("_SECOND_LAYER");
                material.DisableKeyword("_THIRD_LAYER");
                break;
            case StarLayers.Triple:
                material.SetInt("_StarLayers", 2);
                material.EnableKeyword("_SECOND_LAYER");
                material.EnableKeyword("_THIRD_LAYER");
                break;
            default:
                break;
        }
    }
}
