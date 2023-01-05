using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class change_active_character : MonoBehaviour
{
    public GameObject Spartan;
    public GameObject Guardian;
    public GameObject ArtyomMorozov;
    public GameObject ArtyomND_Combat;
    public GameObject ArtyomND_Disguised;
    public GameObject ArtyomND_Formal;
    public GameObject NDGuard;



    public AudioSource HaloAudio;
    public AudioSource DestinyAudio;

    int AvatarID;


    public int AvatarSelector()
    {

        AvatarChanger();

        return AvatarID;

    }
    public int AvatarChanger()
    {

        if (AvatarID==0)
        {
            Spartan.SetActive(false);

            Guardian.SetActive(false);

            ArtyomND_Combat.SetActive(false);

            ArtyomMorozov.SetActive(false);

            ArtyomND_Disguised.SetActive(false);

            ArtyomND_Formal.SetActive(false);
        }
       else if (AvatarID == 1)
        {
            Spartan.SetActive(true);


            Guardian.SetActive(false);

            ArtyomND_Combat.SetActive(false);

            ArtyomMorozov.SetActive(false);

            ArtyomND_Disguised.SetActive(false);

            ArtyomND_Formal.SetActive(false);
        }
        else if(AvatarID == 2)
        {
            Guardian.SetActive(true);


            Spartan.SetActive(false);
    
            ArtyomND_Combat.SetActive(false);

            ArtyomMorozov.SetActive(false);

            ArtyomND_Disguised.SetActive(false);

            ArtyomND_Formal.SetActive(false);
        }
        else if (AvatarID == 3)
        {
            ArtyomND_Combat.SetActive(true);


            Spartan.SetActive(false);

            Guardian.SetActive(false);

            ArtyomMorozov.SetActive(false);

            ArtyomND_Disguised.SetActive(false);

            ArtyomND_Formal.SetActive(false);
        }
      
        else if (AvatarID == 4)
        {
            ArtyomND_Disguised.SetActive(true);


            ArtyomND_Combat.SetActive(false);

            Spartan.SetActive(false);

            Guardian.SetActive(false);

            ArtyomMorozov.SetActive(false);

            ArtyomND_Formal.SetActive(false);
        }
        else if (AvatarID == 5)
        {
            ArtyomND_Formal.SetActive(true);


            ArtyomND_Disguised.SetActive(false);

            ArtyomND_Combat.SetActive(false);

            Spartan.SetActive(false);

            Guardian.SetActive(false);

            ArtyomMorozov.SetActive(false);
        }
        else if (AvatarID == 6)
        {
            ArtyomMorozov.SetActive(true);


            ArtyomND_Formal.SetActive(false);

            ArtyomND_Disguised.SetActive(false);

            ArtyomND_Combat.SetActive(false);

            Spartan.SetActive(false);

            Guardian.SetActive(false);

          
        }

        return AvatarID;
    }

    public void playAnimation(string trigger)
    {
        Spartan.GetComponent<Animator>().SetTrigger(trigger);
        Guardian.GetComponent<Animator>().SetTrigger(trigger);

        ArtyomMorozov.GetComponent<Animator>().SetTrigger(trigger);
        ArtyomND_Combat.GetComponent<Animator>().SetTrigger(trigger);
        ArtyomND_Disguised.GetComponent<Animator>().SetTrigger(trigger);
        ArtyomND_Formal.GetComponent<Animator>().SetTrigger(trigger);
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
