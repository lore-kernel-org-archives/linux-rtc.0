Return-Path: <rtc-linux+bncBDA7X7F2WUEBB2HQWWVQKGQEY7KNFUA@googlegroups.com>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com. [209.85.212.174])
        by gmr-mx.google.com with ESMTPS id p12si644398wiv.1.2015.06.02.02.33.27
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jun 2015 02:33:27 -0700 (PDT)
Received: by mail-wi0-f174.google.com with SMTP id d19so12969749wiw.0
        for <rtc-linux@googlegroups.com>; Tue, 02 Jun 2015 02:33:27 -0700 (PDT)
Date: Tue, 2 Jun 2015 10:33:23 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com, sameo@linux.intel.com,
	a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
	Chao Xie <chao.xie@marvell.com>
Subject: [rtc-linux] Re: [PATCH 4/4] mfd: 88pm800: allocate pdata->rtc if not
 allocated earlier
Message-ID: <20150602093323.GI3329@x1>
References: <1432937962-4537-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1432937962-4537-5-git-send-email-vaibhav.hiremath@linaro.org>
 <20150601082200.GC3329@x1>
 <556D3A14.6050505@linaro.org>
 <20150602074004.GH3329@x1>
 <556D71F6.4030608@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <556D71F6.4030608@linaro.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Tue, 02 Jun 2015, Vaibhav Hiremath wrote:
> On Tuesday 02 June 2015 01:10 PM, Lee Jones wrote:
> >On Tue, 02 Jun 2015, Vaibhav Hiremath wrote:
> >>On Monday 01 June 2015 01:52 PM, Lee Jones wrote:
> >>>On Sat, 30 May 2015, Vaibhav Hiremath wrote:
> >>>
> >>>>RTC in pmic 88PM800 can run even the core is powered off, and user
> >>>>can set alarm in RTC. When the alarm is timed out, the PMIC will powe=
r up
> >>>>the core, and the whole system will boot up. And during PMIC driver p=
robe,
> >>>>it will read some register to find out whether this boot is caused by=
 RTC
> >>>>timeout or not, and pass on this information to the RTC driver.
> >>>>
> >>>>So we need rtc platform data to be existed in PMIC driver to pass thi=
s
> >>>>information.
> >>>>
> >>>>Signed-off-by: Chao Xie <chao.xie@marvell.com>
> >>>>Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
> >>>>---
> >>>>  drivers/mfd/88pm800.c | 19 +++++++++++++++++++
> >>>>  1 file changed, 19 insertions(+)
> >>>>
> >>>>diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
> >>>>index 8ea4467..34546a1 100644
> >>>>--- a/drivers/mfd/88pm800.c
> >>>>+++ b/drivers/mfd/88pm800.c
> >>>>@@ -586,6 +586,25 @@ static int pm800_probe(struct i2c_client *client=
,
> >>>>  			return ret;
> >>>>  	}
> >>>>
> >>>>+	/*
> >>>>+	 * RTC in pmic can run even the core is powered off, and user can s=
et
> >>>>+	 * alarm in RTC. When the alarm is time out, the PMIC will power up
> >>>>+	 * the core, and the whole system will boot up. When PMIC driver is
> >>>>+	 * probed, it will read out some register to find out whether this
> >>>>+	 * boot is caused by RTC timeout or not, and it need pass this
> >>>>+	 * information to RTC driver.
> >>>>+	 * So we need rtc platform data to be existed to pass this informat=
ion.
> >>>>+	 */
> >>>>+	if (!pdata->rtc) {
> >>>>+		pdata->rtc =3D devm_kzalloc(&client->dev,
> >>>>+					  sizeof(*(pdata->rtc)), GFP_KERNEL);
> >>>>+		if (!pdata->rtc) {
> >>>>+			dev_err(&client->dev,
> >>>>+					"failed to allocate memory for rtc\n");
> >>>>+			return -ENOMEM;
> >>>>+		}
> >>>>+	}
> >>>>+
> >>>
> >>>Where is this memory first used?
> >>>
> >>
> >>In the same file, look for field "rtc_wakeup".
> >>
> >>FYI,
> >>
> >>This field is used in two files,
> >>
> >>drivers/mfd/88pm800.c
> >>and
> >>drivers/rtc/rtc-88pm800.c	[sets the "platform_data" field]
> >
> >Then were is the platform_data field subsequently used?
>=20
> Currently not used, but it is for future use, where we would be
> interested to know that the wakeup is really from reset or RTC wakeup.

Well it was introduced 3 years ago, so the chances of it being "used
in the future" are probably pretty low.  Unless of course, you are
planning on submitting that code.  In which case, you can add this
patch to that set and I can re-review it then.

> >Looking at the RTC platform data declaration I see:
> >
> >struct pm80x_rtc_pdata {
> >     int             vrtc;
> >     int             rtc_wakeup;
> >};
> >
> >Is 'vrtc' even used?  If so, where?
>=20
> No, it is not.

So either submit a patch-set that makes use of them, or let me know
that you're not going to do that and I'll remove it altogether.
Likewise for rtc_wakeup.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

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
