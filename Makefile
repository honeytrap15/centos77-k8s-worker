VERSION:=0.1.1

package.box:
	vagrant package

release:
	vagrant cloud publish honeytrap15/centos77-k8s-worker $(VERSION) virtualbox package.box
