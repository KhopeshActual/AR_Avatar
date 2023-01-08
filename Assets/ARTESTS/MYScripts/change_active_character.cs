using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class change_active_character : MonoBehaviour
{

    public GameObject[] Avatars;

    public AudioSource HaloAudio;
    public AudioSource DestinyAudio;
   // public AudioSource[] ArtyAudios;
    public AudioSource MoroAudo;
    public AudioSource WolfAudio;
    public AudioSource RatAudio;
    public int AvatarChanger(int AvatarID)
    {
        for (int i = 0; i < Avatars.Length; i++)
        {
            if (i == AvatarID)
            {
                Avatars[i].SetActive(true);
            }
            else
            {
                Avatars[i].SetActive(false);
            }
        }
       
        return AvatarID;
    }
    public void playAnimation(string toggle)
    {
        for (int i = 0; i < Avatars.Length; i++)
        {
            Avatars[i].GetComponent<Animator>().SetTrigger(toggle);
  
        }
        
    }

    private bool isaudio = true;

    public void ToggleCharacterAudio()
    {
        if (isaudio == true)
        {
            HaloAudio.volume = 0;
            DestinyAudio.volume = 0;

            //ArtyAudios.volume = 0;

            MoroAudo.volume = 0;
            WolfAudio.volume = 0;
            RatAudio.volume = 0;
        }
        else
        {
            HaloAudio.volume = 0.25f;
            DestinyAudio.volume = 0.25f;

           // ArtyAudios.volume = 0.25f;

            MoroAudo.volume = 0.25f;
            WolfAudio.volume = 0.25f;
            RatAudio.volume = 0.25f;
        }
        isaudio = !isaudio;
    }
}
