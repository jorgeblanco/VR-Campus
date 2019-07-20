using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR;

public class rs3DOFCompensator : MonoBehaviour {
    bool simulate3DOF = false;

	void Start () {
        if (XRDevice.GetTrackingSpaceType() == TrackingSpaceType.RoomScale)
        {
            simulate3DOF = true;
        }
        simulate3DOF = true;
    }

    void Update()
    {
        if (simulate3DOF)
        {
            this.transform.localPosition =
                InputTracking.GetLocalPosition(XRNode.RightHand)
                - InputTracking.GetLocalPosition(XRNode.Head);
        }
    }
}
