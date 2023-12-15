using System;
using FlutterUnityIntegration;
using UnityEngine;
using UnityEngine.SceneManagement;
using UniRx;
using System.IO;

public class GameManager : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        gameObject.AddComponent<UnityMessageManager>();
    }

    // Update is called once per frame
    void Update()
    { }

    void HandleWebFnCall(String action)
    {
        switch (action)
        {
            case "pause":
                Time.timeScale = 0;
                break;
            case "resume":
                Time.timeScale = 1;
                break;
            case "unload":
                Application.Unload();
                break;
            case "quit":
                Application.Quit();
                break;
        }
    }

    public void OpenScene(String scene)
    {
        SceneManager.LoadScene(scene);
    }

    public void OpenModel(String modelPath)
    {
        try
        {
            GameObject mainModel = GameObject.Find("MainModel");
            if(mainModel == null)
            {
                GetComponent<UnityMessageManager>().SendMessageToFlutter("mainModel is null!");
            }
            GetComponent<UnityMessageManager>().SendMessageToFlutter("モデル取得：" + modelPath);
            GetComponent<UnityMessageManager>().SendMessageToFlutter("persistence path：" + Application.persistentDataPath);

            mainModel.GetComponent<ModelGenerator>().SetGLB(modelPath);
        }
        catch (Exception e)
        {
            GetComponent<UnityMessageManager>().SendMessageToFlutter("エラー：" + e.ToString());
        }
        
    }
}
