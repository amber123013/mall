package cn.ambermoe.mall.pojo;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
@Entity
@Table(name = "user")
public class User implements Serializable{
    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;
    private String password;
    private String name;
    private String email;
    /* 用于修改密码时临时接受新密码 */
    @Transient
    private String newPassword;
    
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public String getNewPassword() {
        return newPassword;
    }
    public void setNewPassword(String newPassword) {
        this.newPassword = newPassword;
    }
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    /**
     *获取本用户的匿名名称，在评价的时候显示用户名使用 
     */
    public String getAnonymousName() {
        if(null == name)
            return null;
        if(name.length() <= 1)
            return "*";
        if(name.length() == 2)
            return name.substring(0, 1);
        char[] cs = name.toCharArray();
        for(int i = 1; i < cs.length - 1; i++)
            cs[i] = '*';
        return new String(cs);
    }
    @Override
    public String toString() {
        return "User [id=" + id + ", password=" + password + ", name=" + name + "]";
    }
}
