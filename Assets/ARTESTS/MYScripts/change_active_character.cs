using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class change_active_character : MonoBehaviour
{
 
    public GameObject[] Avatars;

    public AudioSource HaloAudio;
    public AudioSource DestinyAudio;


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
    public void playAnimation(string trigger)
    {
        for (int i = 0; i < Avatars.Length; i++)
        {
           Avatars[i].GetComponent<Animator>().SetTrigger(trigger);
  
        }
        
    }

    private bool isaudio = true;

    public void Toggleaudio()
    {
        if (isaudio == true)
        {
            HaloAudio.volume = 0;
            DestinyAudio.volume = 0;
        }
        else
        {
            HaloAudio.volume = 0.5f;
            DestinyAudio.volume = 0.5f;
        }
        isaudio = !isaudio;
    }
}
