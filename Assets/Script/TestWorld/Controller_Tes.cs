using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public enum ContCube {Trigger=0, TriggerUD=1, Grip=2, GripUD=3, TouchPad=4}

public class Controller_Tes : MonoBehaviour
{

	public MeshRenderer[] InputCubes;
	private ContCube cubenum;
	
	private SteamVR_TrackedObject TrackedObj;

	private SteamVR_Controller.Device controller
	{
		get { return SteamVR_Controller.Input((int) TrackedObj.index); }
	}

	private void Awake()
	{
		TrackedObj = GetComponent<SteamVR_TrackedObject>();
	}

	private void Update()
	{
		InputCubes[(int) ContCube.TouchPad].transform.position = controller.GetAxis();
		
		if (controller.GetHairTrigger()) //트리거 누르고 있을 때
		{
			InputCubes[(int)ContCube.Trigger].material.color = Color.red;
		}
		else
		{
			InputCubes[(int)ContCube.Trigger].material.color = Color.white;
		}

		if (controller.GetHairTriggerDown()) //트리거를 눌렀을 때
		{
			if (InputCubes[(int) ContCube.TriggerUD].material.color == Color.red)
				InputCubes[(int) ContCube.TriggerUD].material.color = Color.white;
			InputCubes[(int)ContCube.TriggerUD].material.color = Color.red;
		}

		if (controller.GetPress(SteamVR_Controller.ButtonMask.Grip))
		{
			InputCubes[(int)ContCube.Grip].material.color = Color.red;
		}
		else
		{
			InputCubes[(int) ContCube.Grip].material.color = Color.white;
		}

		if (controller.GetPressDown(SteamVR_Controller.ButtonMask.Grip))
		{
			if (InputCubes[(int) ContCube.GripUD].material.color == Color.red)
				InputCubes[(int) ContCube.GripUD].material.color = Color.white;
			InputCubes[(int)ContCube.GripUD].material.color = Color.red;
		}
		
		
	}
}
