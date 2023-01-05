using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Links : MonoBehaviour
{
    

    // Update is called once per frame
   public void LinkedIn()
    {
        Application.OpenURL("https://www.linkedin.com/in/buckinghamj");
    }

    public void GoogleDrive()
    {
        Application.OpenURL("https://drive.google.com/file/d/1Y-ViVKTjTizM0e9-lsTVu2G5I258UIxG/view?usp=sharing");
    }


    public void Instagram()
    {
        Application.OpenURL("https://www.instagram.com/thefauxboss/");
    }


    public void Twitter()
    {
        Application.OpenURL("https://twitter.com/Jon_and_on");
    }

}
