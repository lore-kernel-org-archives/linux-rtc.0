Return-Path: <rtc-linux+bncBCHOPY7NVYCRBU6E6KVAKGQESSTQ77Y@googlegroups.com>
Received: from mail-ob0-x230.google.com (mail-ob0-x230.google.com. [2607:f8b0:4003:c01::230])
        by gmr-mx.google.com with ESMTPS id k3si215612igf.1.2015.05.20.08.03.47
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 May 2015 08:03:47 -0700 (PDT)
Received: by mail-ob0-x230.google.com with SMTP id ea2so4068620obb.3
        for <rtc-linux@googlegroups.com>; Wed, 20 May 2015 08:03:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6111368.e0EOBSJsmZ@jclayton-pc>
References: <1432055082-28983-1-git-send-email-Frank.Li@freescale.com>
	<20150520142205.GA24844@dragon>
	<CAHrpEqSpeMO=zLyii8qZUznP+9EAQqJ-D3O8hbXj99m+UNvpzA@mail.gmail.com>
	<6111368.e0EOBSJsmZ@jclayton-pc>
Date: Wed, 20 May 2015 10:03:46 -0500
Message-ID: <CAHrpEqQ9F1qXw6RmKPgwpqsFOq=O0dsNL7YtqNQ2ZUVBYz6DSw@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH v2 0/7] Change snvs rtc and poweroff to use
 syscon add pwrkey driver
From: Zhi Li <lznuaa@gmail.com>
To: Joshua Clayton <stillcompiling@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Shawn Guo <shawn.guo@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>, "Frank.Li@freescale.com" <Frank.Li@freescale.com>,
	rtc-linux@googlegroups.com,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-pm@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	alexandre.belloni@free-electrons.com, Philipp Zabel <p.zabel@pengutronix.de>,
	linux-input@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Wed, May 20, 2015 at 9:46 AM, Joshua Clayton
<stillcompiling@gmail.com> wrote:
>>
>> +       snvs_np = of_get_parent(pdev->dev.of_node);
>> +       if (!snvs_np)
>> +               return -ENODEV;
>> +
>> +       data->snvs = syscon_node_to_regmap(snvs_np);
>> +       of_node_put(snvs_np);
>> +
>> +       if (!data->snvs) {
>> +               pr_err("Can't snvs syscon\n");
>> +               return -ENODEV;
>> +       }
>>
>> How about change error message to " Can't snvs syscon, probably use
>> old dts file"?
> How about simply: "Cannot find snvs syscon node in devicetree."

Shawn:
          Are you okay for that?

best regards
Frank Li

>
>
> --
> ~Joshua Clayton

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
