using UnityEngine;
using UnityEngine.SceneManagement;
using System.Collections;

public class SceneController : MonoBehaviour
{

    public void RestartGame()
    {
        SceneManager.LoadScene(SceneManager.GetActiveScene().name); // loads current scene
    }

    public void ShirtScene()
    {
        SceneManager.LoadScene(SceneManager.GetSceneByName("AR Shirt scene").name); // loads shirt scene
    }

    public void AvatarScene()
    {
        SceneManager.LoadScene(SceneManager.GetSceneByName("AR Avatar Scene").name); // loads avatar scene
    }

}