Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBPGQXDFAKGQE4ERMRQI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id 68si1124821wmg.2.2017.06.24.01.52.11
        for <rtc-linux@googlegroups.com>;
        Sat, 24 Jun 2017 01:52:11 -0700 (PDT)
Date: Sat, 24 Jun 2017 10:52:09 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Jose Diaz de Grenu de Pedro <Jose.DiazdeGrenu@digi.com>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com, trivial@kernel.org
Subject: [rtc-linux] Re: [PATCH] drivers: rtc-mxc: remove unused variable
Message-ID: <20170624085209.74caxhzavwktvczr@piout.net>
References: <1494517119-23622-1-git-send-email-Jose.DiazdeGrenu@digi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
In-Reply-To: <1494517119-23622-1-git-send-email-Jose.DiazdeGrenu@digi.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 11/05/2017 at 17:38:39 +0200, Jose Diaz de Grenu de Pedro wrote:
> From: "Diaz de Grenu, Jose" <Jose.DiazdeGrenu@digi.com>
>=20
> This variable was never used. With GCC 6.2, we get the following warning:
>=20
> drivers/rtc/rtc-mxc.c:44:18: warning: =E2=80=98PIE_BIT_DEF=E2=80=99 defin=
ed but not used [-Wunused-const-variable=3D]
>  static const u32 PIE_BIT_DEF[MAX_PIE_NUM][2] =3D {
>=20
> Signed-off-by: Diaz de Grenu, Jose <Jose.DiazdeGrenu@digi.com>
> ---
>  drivers/rtc/rtc-mxc.c | 11 -----------
>  1 file changed, 11 deletions(-)
>=20
Applied, thanks.

--=20
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

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
