Return-Path: <rtc-linux+bncBC62JGFMSINRBDXTY62QKGQE5A24IYA@googlegroups.com>
Date: Wed, 3 Feb 2016 04:58:53 -0800 (PST)
From: dirk.behme@gmail.com
To: rtc-linux <rtc-linux@googlegroups.com>
Cc: dirk.behme@gmail.com, dirk.behme@de.bosch.com, linux@rempel-privat.de,
	alexandre.belloni@free-electrons.com
Message-Id: <15c6e090-33f5-4dd4-82bc-d8b7b1f62dcd@googlegroups.com>
In-Reply-To: <20160203105717.GA20165@piout.net>
References: <460eec38-0a09-4faa-b601-de64803ed5f3@googlegroups.com>
 <20160203105717.GA20165@piout.net>
Subject: [rtc-linux] Re: rtc: RV8803: BUG: scheduling while atomic
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_8969_1579457158.1454504333825"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

------=_Part_8969_1579457158.1454504333825
Content-Type: multipart/alternative;
	boundary="----=_Part_8970_1986614853.1454504333825"

------=_Part_8970_1986614853.1454504333825
Content-Type: text/plain; charset=UTF-8


On Wednesday, February 3, 2016 at 12:07:47 PM UTC+1, Alexandre Belloni 
wrote:
>
> Hi, 
>
> On 03/02/2016 at 01:31:21 -0800, dirk....@gmail.com <javascript:> wrote : 
> > Testing the RV8803 driver [1] we are getting several "BUG: scheduling 
> while 
> > atomic" [2]. 
> > 
> > Having a quick look this might be from rv8803_set_time() holding a 
> spinlock 
> > during the call to i2c_smbus_read_byte_data()? 
> > 
> > Any ideas? 
> > 
>
> Yes, that is probably the case. As this is already a threaded irq, it 
> can probably be changed into a mutex this would solve the issue.
>

Anything like below [1]?

If you like this, we'll test it.

Many thanks

Dirk

[1]

diff --git a/drivers/rtc/rtc-rv8803.c b/drivers/rtc/rtc-rv8803.c
index 33c7e2a..38621ff 100644
--- a/drivers/rtc/rtc-rv8803.c
+++ b/drivers/rtc/rtc-rv8803.c
@@ -52,7 +52,7 @@
 struct rv8803_data {
     struct i2c_client *client;
     struct rtc_device *rtc;
-    spinlock_t flags_lock;
+    struct mutex flags_lock;
     u8 ctrl;
 };
 
@@ -63,11 +63,11 @@ static irqreturn_t rv8803_handle_irq(int irq, void 
*dev_id)
     unsigned long events = 0;
     u8 flags;
 
-    spin_lock(&rv8803->flags_lock);
+    mutex_lock(&rv8803->flags_lock);
 
     flags = i2c_smbus_read_byte_data(client, RV8803_FLAG);
     if (flags <= 0) {
-        spin_unlock(&rv8803->flags_lock);
+        mutex_unlock(&rv8803->flags_lock);
         return IRQ_NONE;
     }
 
@@ -102,7 +102,7 @@ static irqreturn_t rv8803_handle_irq(int irq, void 
*dev_id)
                       rv8803->ctrl);
     }
 
-    spin_unlock(&rv8803->flags_lock);
+    mutex_unlock(&rv8803->flags_lock);
 
     return IRQ_HANDLED;
 }
@@ -155,7 +155,6 @@ static int rv8803_set_time(struct device *dev, struct 
rtc_time *tm)
     struct rv8803_data *rv8803 = dev_get_drvdata(dev);
     u8 date[7];
     int flags, ret;
-    unsigned long irqflags;
 
     if ((tm->tm_year < 100) || (tm->tm_year > 199))
         return -EINVAL;
@@ -173,18 +172,18 @@ static int rv8803_set_time(struct device *dev, struct 
rtc_time *tm)
     if (ret < 0)
         return ret;
 
-    spin_lock_irqsave(&rv8803->flags_lock, irqflags);
+    mutex_lock(&rv8803->flags_lock);
 
     flags = i2c_smbus_read_byte_data(rv8803->client, RV8803_FLAG);
     if (flags < 0) {
-        spin_unlock_irqrestore(&rv8803->flags_lock, irqflags);
+        mutex_unlock(&rv8803->flags_lock);
         return flags;
     }
 
     ret = i2c_smbus_write_byte_data(rv8803->client, RV8803_FLAG,
                     flags & ~RV8803_FLAG_V2F);
 
-    spin_unlock_irqrestore(&rv8803->flags_lock, irqflags);
+    mutex_unlock(&rv8803->flags_lock);
 
     return ret;
 }
@@ -226,7 +225,7 @@ static int rv8803_set_alarm(struct device *dev, struct 
rtc_wkalrm *alrm)
     u8 alarmvals[3];
     u8 ctrl[2];
     int ret, err;
-    unsigned long alarm_time, irqflags;
+    unsigned long alarm_time;
 
     /* The alarm has no seconds, round up to nearest minute */
     if (alrm->time.tm_sec) {
@@ -236,11 +235,11 @@ static int rv8803_set_alarm(struct device *dev, 
struct rtc_wkalrm *alrm)
         rtc_time_to_tm(alarm_time, &alrm->time);
     }
 
-    spin_lock_irqsave(&rv8803->flags_lock, irqflags);
+    mutex_lock(&rv8803->flags_lock);
 
     ret = i2c_smbus_read_i2c_block_data(client, RV8803_FLAG, 2, ctrl);
     if (ret != 2) {
-        spin_unlock_irqrestore(&rv8803->flags_lock, irqflags);
+        mutex_unlock(&rv8803->flags_lock);
         return ret < 0 ? ret : -EIO;
     }
 
@@ -253,14 +252,14 @@ static int rv8803_set_alarm(struct device *dev, 
struct rtc_wkalrm *alrm)
         err = i2c_smbus_write_byte_data(rv8803->client, RV8803_CTRL,
                         rv8803->ctrl);
         if (err) {
-            spin_unlock_irqrestore(&rv8803->flags_lock, irqflags);
+            mutex_unlock(&rv8803->flags_lock);
             return err;
         }
     }
 
     ctrl[1] &= ~RV8803_FLAG_AF;
     err = i2c_smbus_write_byte_data(rv8803->client, RV8803_FLAG, ctrl[1]);
-    spin_unlock_irqrestore(&rv8803->flags_lock, irqflags);
+    mutex_unlock(&rv8803->flags_lock);
     if (err)
         return err;
 
@@ -289,7 +288,6 @@ static int rv8803_alarm_irq_enable(struct device *dev, 
unsigned int enabled)
     struct i2c_client *client = to_i2c_client(dev);
     struct rv8803_data *rv8803 = dev_get_drvdata(dev);
     int ctrl, flags, err;
-    unsigned long irqflags;
 
     ctrl = rv8803->ctrl;
 
@@ -305,15 +303,15 @@ static int rv8803_alarm_irq_enable(struct device 
*dev, unsigned int enabled)
             ctrl &= ~RV8803_CTRL_AIE;
     }
 
-    spin_lock_irqsave(&rv8803->flags_lock, irqflags);
+    mutex_lock(&rv8803->flags_lock);
     flags = i2c_smbus_read_byte_data(client, RV8803_FLAG);
     if (flags < 0) {
-        spin_unlock_irqrestore(&rv8803->flags_lock, irqflags);
+        mutex_unlock(&rv8803->flags_lock);
         return flags;
     }
     flags &= ~(RV8803_FLAG_AF | RV8803_FLAG_UF);
     err = i2c_smbus_write_byte_data(client, RV8803_FLAG, flags);
-    spin_unlock_irqrestore(&rv8803->flags_lock, irqflags);
+    mutex_unlock(&rv8803->flags_lock);
     if (err)
         return err;
 
@@ -333,7 +331,6 @@ static int rv8803_ioctl(struct device *dev, unsigned 
int cmd, unsigned long arg)
     struct i2c_client *client = to_i2c_client(dev);
     struct rv8803_data *rv8803 = dev_get_drvdata(dev);
     int flags, ret = 0;
-    unsigned long irqflags;
 
     switch (cmd) {
     case RTC_VL_READ:
@@ -355,16 +352,16 @@ static int rv8803_ioctl(struct device *dev, unsigned 
int cmd, unsigned long arg)
         return 0;
 
     case RTC_VL_CLR:
-        spin_lock_irqsave(&rv8803->flags_lock, irqflags);
+        mutex_lock(&rv8803->flags_lock);
         flags = i2c_smbus_read_byte_data(client, RV8803_FLAG);
         if (flags < 0) {
-            spin_unlock_irqrestore(&rv8803->flags_lock, irqflags);
+            mutex_unlock(&rv8803->flags_lock);
             return flags;
         }
 
         flags &= ~(RV8803_FLAG_V1F | RV8803_FLAG_V2F);
         ret = i2c_smbus_write_byte_data(client, RV8803_FLAG, flags);
-        spin_unlock_irqrestore(&rv8803->flags_lock, irqflags);
+        mutex_unlock(&rv8803->flags_lock);
         if (ret < 0)
             return ret;
 
@@ -441,6 +438,7 @@ static int rv8803_probe(struct i2c_client *client,
     if (!rv8803)
         return -ENOMEM;
 
+    mutex_init(&rv8803->flags_lock);
     rv8803->client = client;
     i2c_set_clientdata(client, rv8803);
 



 

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

------=_Part_8970_1986614853.1454504333825
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br>On Wednesday, February 3, 2016 at 12:07:47 PM UTC+1, A=
lexandre Belloni wrote:<blockquote class=3D"gmail_quote" style=3D"margin: 0=
;margin-left: 0.8ex;border-left: 1px #ccc solid;padding-left: 1ex;">Hi,
<br>
<br>On 03/02/2016 at 01:31:21 -0800, <a href=3D"javascript:" target=3D"_bla=
nk" gdf-obfuscated-mailto=3D"S6vjvnvCFgAJ" rel=3D"nofollow" onmousedown=3D"=
this.href=3D&#39;javascript:&#39;;return true;" onclick=3D"this.href=3D&#39=
;javascript:&#39;;return true;">dirk....@gmail.com</a> wrote :
<br>&gt; Testing the RV8803 driver [1] we are getting several &quot;BUG: sc=
heduling while=20
<br>&gt; atomic&quot; [2].
<br>&gt;=20
<br>&gt; Having a quick look this might be from rv8803_set_time() holding a=
 spinlock=20
<br>&gt; during the call to i2c_smbus_read_byte_data()?
<br>&gt;=20
<br>&gt; Any ideas?
<br>&gt;=20
<br>
<br>Yes, that is probably the case. As this is already a threaded irq, it
<br>can probably be changed into a mutex this would solve the issue.<br></b=
lockquote><div><br>Anything like below [1]?<br><br>If you like this, we&#39=
;ll test it.<br><br>Many thanks<br><br>Dirk<br><br>[1]<br><br>diff --git a/=
drivers/rtc/rtc-rv8803.c b/drivers/rtc/rtc-rv8803.c<br>index 33c7e2a..38621=
ff 100644<br>--- a/drivers/rtc/rtc-rv8803.c<br>+++ b/drivers/rtc/rtc-rv8803=
.c<br>@@ -52,7 +52,7 @@<br>=C2=A0struct rv8803_data {<br>=C2=A0=C2=A0=C2=A0=
=C2=A0 struct i2c_client *client;<br>=C2=A0=C2=A0=C2=A0=C2=A0 struct rtc_de=
vice *rtc;<br>-=C2=A0=C2=A0=C2=A0 spinlock_t flags_lock;<br>+=C2=A0=C2=A0=
=C2=A0 struct mutex flags_lock;<br>=C2=A0=C2=A0=C2=A0=C2=A0 u8 ctrl;<br>=C2=
=A0};<br>=C2=A0<br>@@ -63,11 +63,11 @@ static irqreturn_t rv8803_handle_irq=
(int irq, void *dev_id)<br>=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long events =
=3D 0;<br>=C2=A0=C2=A0=C2=A0=C2=A0 u8 flags;<br>=C2=A0<br>-=C2=A0=C2=A0=C2=
=A0 spin_lock(&amp;rv8803-&gt;flags_lock);<br>+=C2=A0=C2=A0=C2=A0 mutex_loc=
k(&amp;rv8803-&gt;flags_lock);<br>=C2=A0<br>=C2=A0=C2=A0=C2=A0=C2=A0 flags =
=3D i2c_smbus_read_byte_data(client, RV8803_FLAG);<br>=C2=A0=C2=A0=C2=A0=C2=
=A0 if (flags &lt;=3D 0) {<br>-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 spin_u=
nlock(&amp;rv8803-&gt;flags_lock);<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 mutex_unlock(&amp;rv8803-&gt;flags_lock);<br>=C2=A0=C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 return IRQ_NONE;<br>=C2=A0=C2=A0=C2=A0=C2=A0 }<br>=C2=A0=
<br>@@ -102,7 +102,7 @@ static irqreturn_t rv8803_handle_irq(int irq, void =
*dev_id)<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0 rv8803-&gt;ctrl);<br>=C2=A0=C2=
=A0=C2=A0=C2=A0 }<br>=C2=A0<br>-=C2=A0=C2=A0=C2=A0 spin_unlock(&amp;rv8803-=
&gt;flags_lock);<br>+=C2=A0=C2=A0=C2=A0 mutex_unlock(&amp;rv8803-&gt;flags_=
lock);<br>=C2=A0<br>=C2=A0=C2=A0=C2=A0=C2=A0 return IRQ_HANDLED;<br>=C2=A0}=
<br>@@ -155,7 +155,6 @@ static int rv8803_set_time(struct device *dev, stru=
ct rtc_time *tm)<br>=C2=A0=C2=A0=C2=A0=C2=A0 struct rv8803_data *rv8803 =3D=
 dev_get_drvdata(dev);<br>=C2=A0=C2=A0=C2=A0=C2=A0 u8 date[7];<br>=C2=A0=C2=
=A0=C2=A0=C2=A0 int flags, ret;<br>-=C2=A0=C2=A0=C2=A0 unsigned long irqfla=
gs;<br>=C2=A0<br>=C2=A0=C2=A0=C2=A0=C2=A0 if ((tm-&gt;tm_year &lt; 100) || =
(tm-&gt;tm_year &gt; 199))<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 r=
eturn -EINVAL;<br>@@ -173,18 +172,18 @@ static int rv8803_set_time(struct d=
evice *dev, struct rtc_time *tm)<br>=C2=A0=C2=A0=C2=A0=C2=A0 if (ret &lt; 0=
)<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return ret;<br>=C2=A0<br>-=
=C2=A0=C2=A0=C2=A0 spin_lock_irqsave(&amp;rv8803-&gt;flags_lock, irqflags);=
<br>+=C2=A0=C2=A0=C2=A0 mutex_lock(&amp;rv8803-&gt;flags_lock);<br>=C2=A0<b=
r>=C2=A0=C2=A0=C2=A0=C2=A0 flags =3D i2c_smbus_read_byte_data(rv8803-&gt;cl=
ient, RV8803_FLAG);<br>=C2=A0=C2=A0=C2=A0=C2=A0 if (flags &lt; 0) {<br>-=C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 spin_unlock_irqrestore(&amp;rv8803-&gt;f=
lags_lock, irqflags);<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 mutex_unloc=
k(&amp;rv8803-&gt;flags_lock);<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 return flags;<br>=C2=A0=C2=A0=C2=A0=C2=A0 }<br>=C2=A0<br>=C2=A0=C2=A0=
=C2=A0=C2=A0 ret =3D i2c_smbus_write_byte_data(rv8803-&gt;client, RV8803_FL=
AG,<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 flags &amp; ~RV8803_FLAG_V2F);<br>=C2=A0=
<br>-=C2=A0=C2=A0=C2=A0 spin_unlock_irqrestore(&amp;rv8803-&gt;flags_lock, =
irqflags);<br>+=C2=A0=C2=A0=C2=A0 mutex_unlock(&amp;rv8803-&gt;flags_lock);=
<br>=C2=A0<br>=C2=A0=C2=A0=C2=A0=C2=A0 return ret;<br>=C2=A0}<br>@@ -226,7 =
+225,7 @@ static int rv8803_set_alarm(struct device *dev, struct rtc_wkalrm=
 *alrm)<br>=C2=A0=C2=A0=C2=A0=C2=A0 u8 alarmvals[3];<br>=C2=A0=C2=A0=C2=A0=
=C2=A0 u8 ctrl[2];<br>=C2=A0=C2=A0=C2=A0=C2=A0 int ret, err;<br>-=C2=A0=C2=
=A0=C2=A0 unsigned long alarm_time, irqflags;<br>+=C2=A0=C2=A0=C2=A0 unsign=
ed long alarm_time;<br>=C2=A0<br>=C2=A0=C2=A0=C2=A0=C2=A0 /* The alarm has =
no seconds, round up to nearest minute */<br>=C2=A0=C2=A0=C2=A0=C2=A0 if (a=
lrm-&gt;time.tm_sec) {<br>@@ -236,11 +235,11 @@ static int rv8803_set_alarm=
(struct device *dev, struct rtc_wkalrm *alrm)<br>=C2=A0=C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 rtc_time_to_tm(alarm_time, &amp;alrm-&gt;time);<br>=C2=
=A0=C2=A0=C2=A0=C2=A0 }<br>=C2=A0<br>-=C2=A0=C2=A0=C2=A0 spin_lock_irqsave(=
&amp;rv8803-&gt;flags_lock, irqflags);<br>+=C2=A0=C2=A0=C2=A0 mutex_lock(&a=
mp;rv8803-&gt;flags_lock);<br>=C2=A0<br>=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D i2=
c_smbus_read_i2c_block_data(client, RV8803_FLAG, 2, ctrl);<br>=C2=A0=C2=A0=
=C2=A0=C2=A0 if (ret !=3D 2) {<br>-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 sp=
in_unlock_irqrestore(&amp;rv8803-&gt;flags_lock, irqflags);<br>+=C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 mutex_unlock(&amp;rv8803-&gt;flags_lock);<br>=
=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return ret &lt; 0 ? ret : -EIO;=
<br>=C2=A0=C2=A0=C2=A0=C2=A0 }<br>=C2=A0<br>@@ -253,14 +252,14 @@ static in=
t rv8803_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)<br>=C2=A0=
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 err =3D i2c_smbus_write_byte_data(rv8=
803-&gt;client, RV8803_CTRL,<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 rv8803-&gt;ctrl);<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (er=
r) {<br>-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 spin_unlo=
ck_irqrestore(&amp;rv8803-&gt;flags_lock, irqflags);<br>+=C2=A0=C2=A0=C2=A0=
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 mutex_unlock(&amp;rv8803-&gt;flags_l=
ock);<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ret=
urn err;<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 }<br>=C2=A0=C2=A0=
=C2=A0=C2=A0 }<br>=C2=A0<br>=C2=A0=C2=A0=C2=A0=C2=A0 ctrl[1] &amp;=3D ~RV88=
03_FLAG_AF;<br>=C2=A0=C2=A0=C2=A0=C2=A0 err =3D i2c_smbus_write_byte_data(r=
v8803-&gt;client, RV8803_FLAG, ctrl[1]);<br>-=C2=A0=C2=A0=C2=A0 spin_unlock=
_irqrestore(&amp;rv8803-&gt;flags_lock, irqflags);<br>+=C2=A0=C2=A0=C2=A0 m=
utex_unlock(&amp;rv8803-&gt;flags_lock);<br>=C2=A0=C2=A0=C2=A0=C2=A0 if (er=
r)<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return err;<br>=C2=A0<br>=
@@ -289,7 +288,6 @@ static int rv8803_alarm_irq_enable(struct device *dev, =
unsigned int enabled)<br>=C2=A0=C2=A0=C2=A0=C2=A0 struct i2c_client *client=
 =3D to_i2c_client(dev);<br>=C2=A0=C2=A0=C2=A0=C2=A0 struct rv8803_data *rv=
8803 =3D dev_get_drvdata(dev);<br>=C2=A0=C2=A0=C2=A0=C2=A0 int ctrl, flags,=
 err;<br>-=C2=A0=C2=A0=C2=A0 unsigned long irqflags;<br>=C2=A0<br>=C2=A0=C2=
=A0=C2=A0=C2=A0 ctrl =3D rv8803-&gt;ctrl;<br>=C2=A0<br>@@ -305,15 +303,15 @=
@ static int rv8803_alarm_irq_enable(struct device *dev, unsigned int enabl=
ed)<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ctrl =
&amp;=3D ~RV8803_CTRL_AIE;<br>=C2=A0=C2=A0=C2=A0=C2=A0 }<br>=C2=A0<br>-=C2=
=A0=C2=A0=C2=A0 spin_lock_irqsave(&amp;rv8803-&gt;flags_lock, irqflags);<br=
>+=C2=A0=C2=A0=C2=A0 mutex_lock(&amp;rv8803-&gt;flags_lock);<br>=C2=A0=C2=
=A0=C2=A0=C2=A0 flags =3D i2c_smbus_read_byte_data(client, RV8803_FLAG);<br=
>=C2=A0=C2=A0=C2=A0=C2=A0 if (flags &lt; 0) {<br>-=C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 spin_unlock_irqrestore(&amp;rv8803-&gt;flags_lock, irqflags);<=
br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 mutex_unlock(&amp;rv8803-&gt;flag=
s_lock);<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return flags;<br>=
=C2=A0=C2=A0=C2=A0=C2=A0 }<br>=C2=A0=C2=A0=C2=A0=C2=A0 flags &amp;=3D ~(RV8=
803_FLAG_AF | RV8803_FLAG_UF);<br>=C2=A0=C2=A0=C2=A0=C2=A0 err =3D i2c_smbu=
s_write_byte_data(client, RV8803_FLAG, flags);<br>-=C2=A0=C2=A0=C2=A0 spin_=
unlock_irqrestore(&amp;rv8803-&gt;flags_lock, irqflags);<br>+=C2=A0=C2=A0=
=C2=A0 mutex_unlock(&amp;rv8803-&gt;flags_lock);<br>=C2=A0=C2=A0=C2=A0=C2=
=A0 if (err)<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return err;<br>=
=C2=A0<br>@@ -333,7 +331,6 @@ static int rv8803_ioctl(struct device *dev, u=
nsigned int cmd, unsigned long arg)<br>=C2=A0=C2=A0=C2=A0=C2=A0 struct i2c_=
client *client =3D to_i2c_client(dev);<br>=C2=A0=C2=A0=C2=A0=C2=A0 struct r=
v8803_data *rv8803 =3D dev_get_drvdata(dev);<br>=C2=A0=C2=A0=C2=A0=C2=A0 in=
t flags, ret =3D 0;<br>-=C2=A0=C2=A0=C2=A0 unsigned long irqflags;<br>=C2=
=A0<br>=C2=A0=C2=A0=C2=A0=C2=A0 switch (cmd) {<br>=C2=A0=C2=A0=C2=A0=C2=A0 =
case RTC_VL_READ:<br>@@ -355,16 +352,16 @@ static int rv8803_ioctl(struct d=
evice *dev, unsigned int cmd, unsigned long arg)<br>=C2=A0=C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 return 0;<br>=C2=A0<br>=C2=A0=C2=A0=C2=A0=C2=A0 case=
 RTC_VL_CLR:<br>-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 spin_lock_irqsave(&a=
mp;rv8803-&gt;flags_lock, irqflags);<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 mutex_lock(&amp;rv8803-&gt;flags_lock);<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 flags =3D i2c_smbus_read_byte_data(client, RV8803_FLAG);<br=
>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (flags &lt; 0) {<br>-=C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 spin_unlock_irqrestore(&=
amp;rv8803-&gt;flags_lock, irqflags);<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 mutex_unlock(&amp;rv8803-&gt;flags_lock);<br>=C2=
=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return flags;<b=
r>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 }<br>=C2=A0<br>=C2=A0=C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 flags &amp;=3D ~(RV8803_FLAG_V1F | RV8803_F=
LAG_V2F);<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ret =3D i2c_smbus_=
write_byte_data(client, RV8803_FLAG, flags);<br>-=C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 spin_unlock_irqrestore(&amp;rv8803-&gt;flags_lock, irqflags);<=
br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 mutex_unlock(&amp;rv8803-&gt;flag=
s_lock);<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (ret &lt; 0)<br>=
=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return ret;<=
br>=C2=A0<br>@@ -441,6 +438,7 @@ static int rv8803_probe(struct i2c_client =
*client,<br>=C2=A0=C2=A0=C2=A0=C2=A0 if (!rv8803)<br>=C2=A0=C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 return -ENOMEM;<br>=C2=A0<br>+=C2=A0=C2=A0=C2=A0 mut=
ex_init(&amp;rv8803-&gt;flags_lock);<br>=C2=A0=C2=A0=C2=A0=C2=A0 rv8803-&gt=
;client =3D client;<br>=C2=A0=C2=A0=C2=A0=C2=A0 i2c_set_clientdata(client, =
rv8803);<br>=C2=A0<br><br><br><br>=C2=A0</div></div>

<p></p>

-- <br />
-- <br />
You received this message because you are subscribed to &quot;rtc-linux&quo=
t;.<br />
Membership options at <a href=3D"http://groups.google.com/group/rtc-linux">=
http://groups.google.com/group/rtc-linux</a> .<br />
Please read <a href=3D"http://groups.google.com/group/rtc-linux/web/checkli=
st">http://groups.google.com/group/rtc-linux/web/checklist</a><br />
before submitting a driver.<br />
--- <br />
You received this message because you are subscribed to the Google Groups &=
quot;rtc-linux&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:rtc-linux+unsubscribe@googlegroups.com">rtc-linux=
+unsubscribe@googlegroups.com</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

------=_Part_8970_1986614853.1454504333825--

------=_Part_8969_1579457158.1454504333825--
