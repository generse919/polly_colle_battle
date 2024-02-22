using System.Collections;
using Cysharp.Threading.Tasks;
using FlutterUnityIntegration;
using TMPro;

using UnityEngine;

public class MessageGenerator : MonoBehaviour
{
    AAA.OpenAI.ChatGPTConnection chatGPTConnection;
    [SerializeField]
    TextMeshProUGUI textMeshProUGUI;
    [SerializeField]
    //表示時間(フェードイン、フェードアウト含まない)
    float displayMessageTime = 20.0f;
    [SerializeField]
    Animator animator;
    // Start is called before the first frame update
    void Start()
    {
        chatGPTConnection = new AAA.OpenAI.ChatGPTConnection("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");
        StartCoroutine(GenerateMessage());

    }
    private IEnumerator GenerateMessage()
    {

        while (true)
        {

            yield return chatGPTConnection.RequestAsync("ポリコレが言いそうなセリフを話してください").ToCoroutine(x =>
            {
                textMeshProUGUI.text = x.choices[0].message.content;
                animator.SetFloat("Speed", 1.0f);
                animator.Play("MessageFade", 0, 0);
                Debug.Log("フェードイン");
                UnityMessageManager.Instance.SendMessageToFlutter("ChatGPT:" + x.choices[0].message.content);
            });

            yield return new WaitForSeconds(displayMessageTime);


            animator.SetFloat("Speed", -1.0f);
            animator.Play("MessageFade", 0, 1.0f);
            Debug.Log("フェードアウト");



            //フェードアウトが終了するまで待つ
            while (animator.GetCurrentAnimatorStateInfo(0).normalizedTime < 1.0f)
            {
                yield return null;
            }
        }
    }
}
