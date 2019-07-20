using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using vrCampusCourseware;

public class stuffHider : MonoBehaviour {

    [SerializeField]
    GameObject studyHolder;
    [SerializeField]
    GameObject trackingHolder;
    [SerializeField]
    GameObject interactionHolder;
    [SerializeField]
    GameObject locomotionHolder;
    [SerializeField]
    GameObject VRUXHolder;

    private switchRooms roomSwitcher;

    private void OnEnable()
    {
        roomSwitcher = GameObject.FindObjectOfType<switchRooms>();
        roomSwitcher.onRoomChanged += RoomSwitcher_onRoomChanged;
    }

    private void OnDisable()
    {
        roomSwitcher.onRoomChanged -= RoomSwitcher_onRoomChanged;
    }

    private void RoomSwitcher_onRoomChanged(switchRooms.roomType r)
    {
        switchRoom(r);
    }

    // Use this for initialization
    void Start () {
        roomSwitcher = GameObject.FindObjectOfType<switchRooms>();
//        switchRoom(switchRooms.roomType.Study);
    }

    public void switchRoom(switchRooms.roomType n)
    {
        studyHolder.SetActive(n == switchRooms.roomType.Study);
        trackingHolder.SetActive(n == switchRooms.roomType.Tracking);
        interactionHolder.SetActive(n == switchRooms.roomType.Interaction);
        locomotionHolder.SetActive(n == switchRooms.roomType.Locomotion);
        VRUXHolder.SetActive(n == switchRooms.roomType.VRUX);
    }
}
