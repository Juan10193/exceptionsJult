@Istest
private class getSandboxTypeTest {
	@Istest
    static void getNamedCredentialTest(){
        GetSandboxType.getNamedCredential('DEV');
        GetSandboxType.getNamedCredential('QA');
        GetSandboxType.getNamedCredential('PROD');
        GetSandboxType.getNamedCredential('Developer Edition');
        GetSandboxType.getTypeOfSandbox();
    }
}