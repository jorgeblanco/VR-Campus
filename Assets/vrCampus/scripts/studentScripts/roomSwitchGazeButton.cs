using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using vrCampusCourseware;
using TMPro;

[RequireComponent(typeof(gazeableObject))]
[RequireComponent(typeof(Renderer))]
public class roomSwitchGazeButton : MonoBehaviour {

    [SerializeField] private Material m_NormalMaterial;
    [SerializeField] private Material m_OverMaterial;
    [SerializeField] private Material m_SelectedMaterial;

    [SerializeField] private float m_Scale;

    [SerializeField] private Color labelSelectedColor = new Color(0.77f,0.9f,1,1);
    [SerializeField] private Color labelUnselectedColor = new Color(0.33f, 0.75f, 1, 1);

    [SerializeField] switchRooms.roomType rType;

    private bool m_GazeOver;
    private bool m_Selected;

    private TextMeshPro tmpLabel;
    private gazeableObject m_InteractiveItem;
    private Renderer m_Renderer;
    private gazeTimerVisual m_SelectionRadial;
    private switchRooms roomSwitcher;
    switchRooms.roomType curRoom = vrCampusCourseware.switchRooms.roomType.Study;
    private Material m_outMaterial;


    private void Awake()
    {
        m_InteractiveItem = this.GetComponent<gazeableObject>();
        m_Renderer = this.GetComponent<Renderer>();
        tmpLabel = GetComponentInChildren<TextMeshPro>();
        roomSwitcher = FindObjectOfType<switchRooms>();
        m_SelectionRadial = FindObjectOfType<gazeTimerVisual>();

        if (m_Renderer)
        {
            m_Renderer.material = m_NormalMaterial;
        }

        setRoom(curRoom);
    }


    private void OnEnable()
    {
        m_InteractiveItem.OnOver += HandleOver;
        m_InteractiveItem.OnOut += HandleOut;
        m_SelectionRadial.OnSelectionComplete += HandleSelectionComplete;
        roomSwitcher.onRoomChanged += RoomSwitcher_onRoomChanged;
    }


    private void OnDisable()
    {
        m_InteractiveItem.OnOver -= HandleOver;
        m_InteractiveItem.OnOut -= HandleOut;
        m_SelectionRadial.OnSelectionComplete -= HandleSelectionComplete;
        roomSwitcher.onRoomChanged -= RoomSwitcher_onRoomChanged;
    }

    private void RoomSwitcher_onRoomChanged(switchRooms.roomType r)
    {
        setRoom(r);
    }

    public void setRoom(switchRooms.roomType type)
    {
        curRoom = type;
        if (curRoom == rType)
        {
            m_Selected = true;
            if (m_Renderer)
            {
                m_Renderer.material = m_SelectedMaterial;
            }
            tmpLabel.color = labelSelectedColor;
            m_outMaterial = m_SelectedMaterial;
        }
        else
        {
            if (m_Renderer)
            {
                m_Renderer.material = m_NormalMaterial;
            }
            tmpLabel.color = labelUnselectedColor;
            m_outMaterial = m_NormalMaterial;
        }
    }

    private void HandleSelectionComplete()
    {
        // If the user is looking at the rendering of the scene when the radial's 
        // selection finishes, activate the button.
        if (m_GazeOver)
        {
            if (roomSwitcher != null && roomSwitcher.allowSwitch)
            {
                roomSwitcher.onSwitchRoom(rType);
            }
        }
    }


    //Handle the Over event
    private void HandleOver()
    {
        m_GazeOver = true;

        if (m_Scale > 1.0f)
            this.transform.localScale = new Vector3(m_Scale, m_Scale, m_Scale);

        if (m_Renderer)
        {
            m_Renderer.material = m_OverMaterial;
        }
    }


    //Handle the Out event
    private void HandleOut()
    {
        // When the user looks away from the rendering of the scene, hide the radial.
        if (butPressedOnMe)
        {
            butPressedOnMe = false;
            m_SelectionRadial.Hide();
        }

        m_GazeOver = false;
        if (m_Scale > 1.0f)
            this.transform.localScale = Vector3.one;

        if (m_Renderer)
        {
            m_Renderer.material = m_outMaterial;
        }
 
    }

    bool butPressedOnMe = false;
    void Update()
    {
        if (m_GazeOver)
        {
            if (Input.GetButtonDown("Fire1"))
            {
                butPressedOnMe = true;
                m_SelectionRadial.Show();
            }
            if (Input.GetButtonUp("Fire1"))
            {
                butPressedOnMe = false;
                m_SelectionRadial.Hide();
            }
        }
    }
}
