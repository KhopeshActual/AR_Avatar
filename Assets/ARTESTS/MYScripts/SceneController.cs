using UnityEngine;
using UnityEngine.SceneManagement;
using System.Collections;
using UnityEngine.XR.ARFoundation;
using UnityEngine.Analytics;

public class SceneController : MonoBehaviour
{
    public AudioSource SceneAudio;
    public GameObject CharacterController;

    public void RestartGame()
    {
        SceneManager.LoadScene(SceneManager.GetActiveScene().name); // loads current scene
    }

    public void ShirtScene()
    {
        LoaderUtility.Deinitialize();
        LoaderUtility.Initialize();
        SceneManager.LoadScene("AR Shirt Scene_V2b", LoadSceneMode.Single); // loads shirt scene
    }

    public void AvatarScene()
    {
        LoaderUtility.Deinitialize();
        LoaderUtility.Initialize();
        SceneManager.LoadScene("AR Avatar Scene", LoadSceneMode.Single); // loads avatar scene
    }

    private bool isaudio = true;
    public void ToggleSceneAudio()
    {
        SceneAudio = FindObjectOfType<AudioSource>();

        if (isaudio == true)
        {
            SceneAudio.volume = 0;
        }
        else
        {
            SceneAudio.volume = 025f;
        }
        isaudio = !isaudio;
    }

    public void FindCharacterAudio()
    {

        CharacterController.GetComponent<change_active_character>().ToggleCharacterAudio();
    }
}