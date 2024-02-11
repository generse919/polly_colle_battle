using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UniRx;


#if UNITY_EDITOR
[ExecuteInEditMode]
#endif
public class CameraManager : MonoBehaviour
{
    enum CAMERAS
    {
        CAMERA_1,
        CAMERA_2,
        CAMERA_MAX,
    }
    [SerializeField]
    Camera[] cameras;
#if UNITY_EDITOR
    [SerializeField]
    CAMERAS renderMode = CAMERAS.CAMERA_1;

#endif

    // Start is called before the first frame update
    void Start()
    {
        this
           .ObserveEveryValueChanged(self => self.renderMode)
           .Subscribe(onRenderModeChanged);
    }

    // Update is called once per frame
    void Update()
    {
#if UNITY_EDITOR
        
#endif
    }

    void onRenderModeChanged(CAMERAS newValue)
    {
        for(int i = 0; i < cameras.Length; i++)
        {
            cameras[i].gameObject.SetActive((int)newValue == i);
        }
    }
}
