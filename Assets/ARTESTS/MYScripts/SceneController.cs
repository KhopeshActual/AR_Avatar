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
        SceneManager.LoadScene("AR Shirt Scene", LoadSceneMode.Single); // loads shirt scene
    }

    public void AvatarScene()
    {
        SceneManager.LoadScene("AR Avatar Scene", LoadSceneMode.Single); // loads avatar scene
    }

}