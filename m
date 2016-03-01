Return-Path: <rtc-linux+bncBDS7HNEFSALRBQ7G223AKGQE5GG6YFI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id h126si21666wme.0.2016.03.01.07.20.34
        for <rtc-linux@googlegroups.com>;
        Tue, 01 Mar 2016 07:20:34 -0800 (PST)
Date: Tue, 1 Mar 2016 16:20:34 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH] rtc: rtc-vr41xx: remove unused function
Message-ID: <20160301152034.GA23985@piout.net>
References: <1456836981-30999-1-git-send-email-sudipm.mukherjee@gmail.com>
 <20160301145558.GC26201@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160301145558.GC26201@ulmo>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 01/03/2016 at 15:55:58 +0100, Thierry Reding wrote :
> On Tue, Mar 01, 2016 at 06:26:21PM +0530, Sudip Mukherjee wrote:
> > We were getting build warning about:
> > drivers/rtc/rtc-vr41xx.c:228:12: warning: =E2=80=98vr41xx_rtc_alarm_irq=
_enable=E2=80=99
> > defined but not used
> >=20
> > The function vr41xx_rtc_alarm_irq_enable() was not used anywhere.
> >=20
> > Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> > ---
> >=20
> > build log is at:
> > https://travis-ci.org/sudipm-mukherjee/parport/jobs/112780206
> >=20
> >  drivers/rtc/rtc-vr41xx.c | 18 ------------------
> >  1 file changed, 18 deletions(-)
> >=20
> > diff --git a/drivers/rtc/rtc-vr41xx.c b/drivers/rtc/rtc-vr41xx.c
> > index f64c282..68cb63e 100644
> > --- a/drivers/rtc/rtc-vr41xx.c
> > +++ b/drivers/rtc/rtc-vr41xx.c
> > @@ -225,24 +225,6 @@ static int vr41xx_rtc_ioctl(struct device *dev, un=
signed int cmd, unsigned long
> >  	return 0;
> >  }
> > =20
> > -static int vr41xx_rtc_alarm_irq_enable(struct device *dev, unsigned in=
t enabled)
> > -{
> > -	spin_lock_irq(&rtc_lock);
> > -	if (enabled) {
> > -		if (!alarm_enabled) {
> > -			enable_irq(aie_irq);
> > -			alarm_enabled =3D 1;
> > -		}
> > -	} else {
> > -		if (alarm_enabled) {
> > -			disable_irq(aie_irq);
> > -			alarm_enabled =3D 0;
> > -		}
> > -	}
> > -	spin_unlock_irq(&rtc_lock);
> > -	return 0;
> > -}
> > -
>=20
> I don't think it's supposed to be unused, rather back at the time it
> simply wasn't hooked up to the rtc_class_ops.
>=20
> Here's what I used.
>=20

I've already applied the patch from Geert which does the same.


--=20
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--=20
--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
