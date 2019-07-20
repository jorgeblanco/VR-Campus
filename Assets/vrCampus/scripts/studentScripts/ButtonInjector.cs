using UnityEngine;
using UnityEngine.UI;
using UnityEngine.EventSystems;
using System.Collections;

public class ButtonInjector : MonoBehaviour {

    private Button _button;

    // Use this for initialization
    void Start () {

        // get the button we are adapting
        _button = this.GetComponent<Button>();
        if (_button == null )
        {
            Debug.LogError("Failed to find valid reference to the Button.");
        }


        // adjust the box collider size
        BoxCollider boxCollider = this.GetComponent<BoxCollider>();
        if (boxCollider == null)
        {
            // create a box collider if one does not exit
            boxCollider = this.gameObject.AddComponent<BoxCollider>();
            boxCollider.size = new Vector3(_button.GetComponent<RectTransform>().rect.width, _button.GetComponent<RectTransform>().rect.height, 1.0f);
        }
    }

    public void OnEnter()
    {
        var pointer = new PointerEventData(EventSystem.current);
        ExecuteEvents.Execute(_button.gameObject, pointer, ExecuteEvents.pointerEnterHandler);
    }

    public void OnLeave()
    {
        var pointer = new PointerEventData(EventSystem.current);
        ExecuteEvents.Execute(_button.gameObject, pointer, ExecuteEvents.pointerExitHandler);
    }

    public void OnPress()
    {
        var pointer = new PointerEventData(EventSystem.current);
        ExecuteEvents.Execute(_button.gameObject, pointer, ExecuteEvents.pointerDownHandler);
    }

    public void OnRelease()
    {
        var pointer = new PointerEventData(EventSystem.current);
        ExecuteEvents.Execute(_button.gameObject, pointer, ExecuteEvents.pointerUpHandler);
        ExecuteEvents.Execute(_button.gameObject, pointer, ExecuteEvents.submitHandler);
    }
}
