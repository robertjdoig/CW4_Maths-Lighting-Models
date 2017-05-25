using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class carRotation : MonoBehaviour {

    [SerializeField]
    private float rotationSpeed = 0.5f;

	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
        transform.Rotate(0, -rotationSpeed, 0); 
	}
}
