using UnityEngine;
using UnityEngine.UI;

public class PlayerUIController : MonoBehaviour
{

    [SerializeField]
    PlayerData playerData;
    [SerializeField]
    Slider slider;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        slider.value = playerData.playerHP;
    }
}
