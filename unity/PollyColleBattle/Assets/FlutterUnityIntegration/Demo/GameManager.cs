using System;
using FlutterUnityIntegration;
using UnityEngine;
using UnityEngine.SceneManagement;




public class GameManager : MonoBehaviour
{

    public bool isDarkMode = false;

    public int controlUseIndex = 0;

    // Start is called before the first frame update
    void Start()
    {
        gameObject.AddComponent<UnityMessageManager>();
#if UNITY_EDITOR || UNITY_EDITOR_OSX
        foreach(var o in GameObject.FindGameObjectsWithTag("Untagged"))
        {
            Debug.Log(o.name);
            if(o.name == "glTF-StableFramerate")
            {
                Destroy(o);
            }
        }
#endif
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



    /// <summary>
    /// ダークモードチェック
    /// ネイティブから呼び出し可能だが、OSによって作り変えるのが面倒なため、Flutter側から判定する。
    /// </summary>
    /// <returns></returns>
    public void SetDarkMode(bool flag)
    {
        isDarkMode = flag;
    }

    


}
