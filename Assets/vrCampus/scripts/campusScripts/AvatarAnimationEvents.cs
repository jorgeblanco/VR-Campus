using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AvatarAnimationEvents : MonoBehaviour {

	[SerializeField] vrCampusCourseware.dioramaController controller;
	[SerializeField] AudioSource ballHit;


	//The script only needs to work on the Avatar Character but it has to be on both so the animation events have a target method.
	[SerializeField] bool isOn;

	public void Bounce() {
		if (isOn) {
			ballHit.Play();
		}
	}

	public void Hit() {
		if (isOn) {
			ballHit.Play();
		}
	}

	public void EndActing() {
		if (isOn) {
			controller.StartBallAnimation();
		}
	}

	public void PingPongCycleEnd() {
		if (isOn) {
			controller.ComfortSettingsCheck();
		}
	}

}
