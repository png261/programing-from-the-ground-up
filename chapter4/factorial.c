int factorial(int n) {
    if(n == 1) {
        return;
    }
    return n * factorial(n - 1); 
}

int main(){
    return factorial(5); 
}