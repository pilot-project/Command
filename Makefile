all:
	swift build
	git init ; git add . ; git commit -m "Commit" ; git tag 1.0.0

clean:
	rm -rf .build
	rm -rf .git
	rm *~ Sources/*~

