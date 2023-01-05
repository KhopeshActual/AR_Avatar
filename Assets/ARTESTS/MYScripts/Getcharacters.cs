using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;

public class Getcharacters : MonoBehaviour
{

    public string[] SpartanAnimations;
    public string[] GuardianAnimations;
    public string[] NDGuardAnimations;
    public string[] ArtyomNDAnimations;
    public string[] ArtyomMorozovAnimations;


    public int[] AvatarList;
    public int AvatarID;

    public TMP_Dropdown Animations;
    public TMP_Dropdown Avatars;

    public void Start()
    {
        SetAnimDropdown(1);
        
    }
    public void Audiotoggle()
    {
        FindObjectOfType<change_active_character>().Toggleaudio();
    }

    public void AvatarPicker(int i)
    {
        AvatarID = FindObjectOfType<change_active_character>().AvatarChanger();

       
        SetAnimDropdown(AvatarID);
        SetAvatarDropdown(AvatarID);
    }


    public void AnimationPicker(int i)
    {
        FindObjectOfType<change_active_character>().playAnimation(Animations.options[i].text);

    }

    private void SetAnimDropdown(int ID)
    {
        Animations.options.Clear();
       

        if (AvatarID == 1)
        {
            ID= 1;
            foreach (string Anim in SpartanAnimations)
            {
                Animations.options.Add(new TMP_Dropdown.OptionData(Anim));

            }
        }
        else if (AvatarID == 2)
        {
            ID= 2;
            foreach (string Anim in GuardianAnimations)
            {
                Animations.options.Add(new TMP_Dropdown.OptionData(Anim));

            }
        }
        else if (AvatarID >2 && AvatarID <= 5)
        {
            ID= AvatarID;
            foreach (string Anim in ArtyomNDAnimations)
            {
                Animations.options.Add(new TMP_Dropdown.OptionData(Anim));

            }
        }
        else if (AvatarID == 6)
        {
            ID = 6;
            foreach (string Anim in ArtyomMorozovAnimations)
            {
                Animations.options.Add(new TMP_Dropdown.OptionData(Anim));

            }
        }
    }
    private void SetAvatarDropdown(int AvatarID)
    {
        Avatars.options.Clear();


        if (AvatarID == 0)
        {
            foreach (int ID  in AvatarList)
            {
                Avatars.options.Add(new TMP_Dropdown.OptionData("Avatar " + ID));

            }
        }
        
    }
}
