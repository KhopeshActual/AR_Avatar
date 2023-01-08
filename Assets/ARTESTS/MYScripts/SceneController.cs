using UnityEngine;
using UnityEngine.SceneManagement;
using System.Collections;
using UnityEngine.XR.ARFoundation;

public class SceneController : MonoBehaviour
{

    public void RestartGame()
    {
        SceneManager.LoadScene(SceneManager.GetActiveScene().name); // loads current scene
    }

    public void ShirtScene()
    {
        LoaderUtility.Deinitialize();
        LoaderUtility.Initialize();
        SceneManager.LoadScene("AR Shirt Scene_V2a", LoadSceneMode.Single); // loads shirt scene
    }

    public void AvatarScene()
    {
        LoaderUtility.Deinitialize();
        LoaderUtility.Initialize();
        SceneManager.LoadScene("AR Avatar Scene", LoadSceneMode.Single); // loads avatar scene
    }

}