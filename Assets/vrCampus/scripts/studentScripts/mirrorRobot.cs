using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR;

public class mirrorRobot : MonoBehaviour {

	// Update is called once per frame
	void Update () {
        // we're using these as a quick example
        // but we learned why we shouldn't use these
        Vector3 pos = InputTracking.GetLocalPosition(XRNode.RightHand);
        Quaternion rot = InputTracking.GetLocalRotation(XRNode.RightHand);

        // think in terms of what 'heading' your sword has from you
        // and try to make your opponent have the opposite heading
        // then set the position of their sword to that heading

        // for the rotation of the sword, try to think of how
        // you can invert the horizontal rotation, but not the vertical
    }

    private void OnPostRender()
    {
        // It would be interesting to see if these change between
        // Update and Render when a Tracked Pose Driver is used
        Vector3 pos = InputTracking.GetLocalPosition(XRNode.RightHand);
        Quaternion rot = InputTracking.GetLocalRotation(XRNode.RightHand);
    }
}
