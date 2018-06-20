using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RippleTest : MonoBehaviour
{
    public MeshRenderer mesh;

    private void Start()
    {
        StartCoroutine(Test());
    }

    IEnumerator Test()
    {
        while (true)
        {
            float ripple = mesh.material.GetFloat("_isRipple");
            if (ripple<=0)
            {
                
            }
            
            yield return new WaitForSeconds(5f);
        }
    }
}
