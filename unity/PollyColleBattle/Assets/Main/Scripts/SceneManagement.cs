using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SceneManagement : MonoBehaviour
{
    [SerializeField]
    GameObject loadingPanelAsset;
    Animator _animator;

    [SerializeField]
    
    // Start is called before the first frame update
    void Start()
    {
        _animator = loadingPanelAsset.GetComponent<Animator>();
#if UNITY_EDITOR
        LoadingFadeOut();
#endif

    }

    public void LoadingFadeIn()
    {
        _animator.SetFloat("Speed", 1.0f);
        _animator.Play("Fade", 0, 0.0f);
    }

    public void LoadingFadeOut()
    {
        _animator.SetFloat("Speed", -1.0f);
        _animator.Play("Fade", 0, 1.0f);
    }

}
