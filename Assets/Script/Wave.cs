using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Wave : MonoBehaviour {
	private void OnCollisionEnter(Collision other)
	{
		ShaderMgr.instance.SoundOn(other.contacts[0].point, 5, 3);
		Debug.Log(other.contacts[0].point.ToString());
	}
}
