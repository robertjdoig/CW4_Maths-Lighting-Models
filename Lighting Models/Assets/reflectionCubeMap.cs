using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class reflectionCubeMap : MonoBehaviour {

    public ReflectionProbe rp;
    public MeshRenderer mr;

    List<ReflectionProbe> refl;

    public Texture mat; 

    // Use this for initialization
    void Start() {
	
    }
	// Update is called once per frame
	void Update () {
        mr = gameObject.GetComponent<MeshRenderer>();
        mat = rp.bakedTexture; 
        mr.material.SetTexture("_CubeMap", mat);       //rp.customBakedTexture);
		
	}
}
