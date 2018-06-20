using System.Collections;
using System.Collections.Generic;
using System.Deployment.Internal;
using UnityEngine;
using Valve.VR;

public class ShaderMgr : MonoBehaviour
{
    public static ShaderMgr instance;

    public string Shader_VectorName = "_SoundPos";
    public string Shader_DistanceName = "_Distance";
    public string Shader_RetainName = "_RatainTime";

    private Vector3 SoundedPos;
    private Collider[] SoundedObjs;

    private void Awake()
    {
        if (instance == null)
            instance = this;
        
    }

    private void Start()
    {
        SoundOn(new Vector3(0, 0, 0), 1f, 3f);
    }

    public void SoundOn(Vector3 soundedpos, float distance, float retaintime)
    {
        SoundedObjs = Physics.OverlapSphere(soundedpos, distance);

        for (int i = 0; i < SoundedObjs.Length; i++)
        {

            SoundedObjs[i].GetComponent<MeshRenderer>().material.SetVector(Shader_VectorName, soundedpos);
            SoundedObjs[i].GetComponent<MeshRenderer>().material.SetFloat(Shader_DistanceName, distance);
            SoundedObjs[i].GetComponent<MeshRenderer>().material.SetFloat(Shader_RetainName, retaintime);
            SoundedObjs[i].GetComponent<MeshRenderer>().material.SetFloat("_isRipple", 1);
        }
        StartCoroutine(Retain(retaintime));
    }

    public void SoundOff()
    {
        for (int i = 0; i < SoundedObjs.Length; i++)
        {
            SoundedObjs[i].GetComponent<MeshRenderer>().material.SetVector(Shader_VectorName, Vector4.zero);
            SoundedObjs[i].GetComponent<MeshRenderer>().material.SetFloat(Shader_DistanceName, 0);
            SoundedObjs[i].GetComponent<MeshRenderer>().material.SetFloat(Shader_RetainName, 0);
            SoundedObjs[i].GetComponent<MeshRenderer>().material.SetFloat("_isRipple", 0);
        }
        StopAllCoroutines();
        
    }

    IEnumerator Retain(float retain)
    {
        Debug.Log("StartRetain...");
        yield return new WaitForSeconds(retain);
        Debug.Log("StopRetain...");
        SoundOff();
        
    }
}
