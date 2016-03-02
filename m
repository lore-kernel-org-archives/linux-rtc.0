Return-Path: <rtc-linux+bncBCC6ZWOPXENRBB7L3K3AKGQEQ3BYIYA@googlegroups.com>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de. [2001:67c:670:201:290:27ff:fe1d:cc33])
        by gmr-mx.google.com with ESMTPS id w128si116830wmd.0.2016.03.02.01.42.30
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 02 Mar 2016 01:42:31 -0800 (PST)
From: Juergen Borleis <jbe@pengutronix.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] Re: [abelloni:rtc-testing 55/55] drivers/rtc/rtc-pcf85063.c:72:19:
 warning: unused variable 'pcf85063'
Date: Wed, 2 Mar 2016 10:44:29 +0100
Cc: kbuild test robot <fengguang.wu@intel.com>,
 rtc-linux@googlegroups.com,
 Alessandro Zummo <a.zummo@towertech.it>,
 linux-kernel@vger.kernel.org
References: <201603020626.sgWd959D%fengguang.wu@intel.com>
In-Reply-To: <201603020626.sgWd959D%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201603021044.29444.jbe@pengutronix.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Alexandre,

On Tuesday 01 March 2016 23:17:45 kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git
> rtc-testing head:   58992ebde059d7faeab4c18bc17713c3b4c31208
> commit: 58992ebde059d7faeab4c18bc17713c3b4c31208 [55/55] rtc: pcf85063:
> remove useless century handling config: x86_64-randconfig-x012-201609
> (attached as .config)
> reproduce:
>         git checkout 58992ebde059d7faeab4c18bc17713c3b4c31208
>         # save the attached .config to linux build tree
>         make ARCH=3Dx86_64
>
> All warnings (new ones prefixed by >>):
>
>    drivers/rtc/rtc-pcf85063.c: In function 'pcf85063_get_datetime':
> >> drivers/rtc/rtc-pcf85063.c:72:19: warning: unused variable 'pcf85063'
> >> [-Wunused-variable]
>
>      struct pcf85063 *pcf85063 =3D i2c_get_clientdata(client);
>                       ^

Due to your removement of the useless century handling the last user of 'st=
ruct=20
pcf85063' is gone. Seems we can remove this struct entirely. What do you=20
think?

Regards,
Juergen

=2D-=20
Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| Juergen Borleis =A0 =A0 =A0 =A0 =A0 =A0 |
Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| http://=
www.pengutronix.de/ =A0|
