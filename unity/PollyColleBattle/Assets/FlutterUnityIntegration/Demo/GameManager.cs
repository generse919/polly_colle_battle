using System;
using FlutterUnityIntegration;
using UnityEngine;
using UnityEngine.SceneManagement;




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


    [Serializable]
    public class OpenModelParam
    {
        public string  path;
        public string  objName;
    }

    /// <summary>
    ///  
    /// </summary>
    /// <param name="param">OpenModelParamのJson文字列</param>
    public void OpenModel(string param)
    {
        try
        {

            //UnityMessageManager.Instance.SendMessageToFlutter(param);
            Debug.Log(param);
            var omp = JsonUtility.FromJson<OpenModelParam>(param);
            Debug.Log(omp.objName);
            Debug.Log(omp.path);
            GameObject mainModel = GameObject.Find(omp.objName);
            if(mainModel == null)
            {
                GetComponent<UnityMessageManager>().SendMessageToFlutter("mainModel is null!");
            }
            GetComponent<UnityMessageManager>().SendMessageToFlutter("モデル取得：" + omp.path);
            GetComponent<UnityMessageManager>().SendMessageToFlutter("persistence path：" + Application.persistentDataPath);

            mainModel.GetComponent<ModelGenerator>().SetGLB(omp.path);
        }
        catch (Exception e)
        {
            GetComponent<UnityMessageManager>().SendMessageToFlutter("エラー：" + e.ToString());
        }
        
    }
}
