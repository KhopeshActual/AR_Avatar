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
    public int AvatarID =0;

    public TMP_Dropdown AnimationsDropdown;
    public TMP_Dropdown AvatarsDropdown;

    public void Start()
    {
        SetDropdowns();
        AvatarSelector();
    }
    public void Audiotoggle()
    {
        FindObjectOfType<change_active_character>().Toggleaudio();
    }
    public void AvatarSelector()
    {
       
        AvatarID = FindObjectOfType<change_active_character>().AvatarChanger(AvatarsDropdown.value);
        SetAnimDropdown(AvatarID);
        
    }
    public void SetDropdowns()
    {
        SetAnimDropdown(AvatarID);
        SetAvatarDropdown(AvatarID);
    }


    public void AnimationSelector()
    {
        FindObjectOfType<change_active_character>().playAnimation(AnimationsDropdown.options[AnimationsDropdown.value].text);
    }

    private void SetAnimDropdown(int AvatarID)
    {
        AnimationsDropdown.options.Clear();
       

        if (AvatarID == 0)
        {
            AvatarID= 0;
            foreach (string Anim in SpartanAnimations)
            {
                AnimationsDropdown.options.Add(new TMP_Dropdown.OptionData(Anim));

            }
        }
        else if (AvatarID == 1)
        {
            AvatarID =1;
            foreach (string Anim in GuardianAnimations)
            {
                AnimationsDropdown.options.Add(new TMP_Dropdown.OptionData(Anim));

            }
        }
        else if (AvatarID >1 && AvatarID <= 4)
        {
            AvatarID = 2;
            foreach (string Anim in ArtyomNDAnimations)
            {
                AnimationsDropdown.options.Add(new TMP_Dropdown.OptionData(Anim));

            }
        }
        else if (AvatarID == 5)
        {
            AvatarID = 5;
            foreach (string Anim in ArtyomMorozovAnimations)
            {
                AnimationsDropdown.options.Add(new TMP_Dropdown.OptionData(Anim));

            }
        }
    }
    private void SetAvatarDropdown(int AvatarID)
    {
        AvatarsDropdown.options.Clear();


        if (AvatarID == 0)
        {
            foreach (int ID  in AvatarList)
            {
                AvatarsDropdown.options.Add(new TMP_Dropdown.OptionData("Avatar " + ID));

            }
        }
        
    }
}
