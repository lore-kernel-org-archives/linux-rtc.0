Return-Path: <sathyaosid@gmail.com>
Subject: Re: [RFC v8 1/7] platform/x86: intel_punit_ipc: Fix resource ioremap
 warning
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, "x86@kernel.org"
 <x86@kernel.org>, Wim Van Sebroeck <wim@iguana.be>,
 Ingo Molnar <mingo@redhat.com>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Zha Qipeng <qipeng.zha@intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "dvhart@infradead.org" <dvhart@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Lee Jones <lee.jones@linaro.org>,
 Andy Shevchenko <andy@infradead.org>,
 Souvik Kumar Chakravarty <souvik.k.chakravarty@intel.com>,
 linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Platform Driver <platform-driver-x86@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <cover.1509268570.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <0ed06c9aabd0f6d707f3ab8024282a764ffe0318.1509268570.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAHp75VffZCTgsbgm3RU-vAL4Xf1A60NtDaFwaLQRp5UqtztfuQ@mail.gmail.com>
From: "Kuppuswamy, Sathyanarayanan" <sathyaosid@gmail.com>
Message-ID: <1279ceb8-0e32-afa8-5544-2b7c92586a93@gmail.com>
Date: Fri, 3 Nov 2017 08:31:49 -0700
MIME-Version: 1.0
In-Reply-To: <CAHp75VffZCTgsbgm3RU-vAL4Xf1A60NtDaFwaLQRp5UqtztfuQ@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------6E5C238BD1F3158DE4949113"
List-ID: <linux-rtc.vger.kernel.org>

This is a multi-part message in MIME format.
--------------6E5C238BD1F3158DE4949113
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andy,


On 11/3/2017 5:13 AM, Andy Shevchenko wrote:
> I think I already told that this one had been pushed to my review and
> testing queue, thanks!
I thought you specifically asked me to include this patch in next set. 
Following is your previous comment. Patch 3 in your reply points to this 
patch.

>> I have applied this patch with  some modifications to my review-andy branch.
>> Please, take it from there (and  probably patch 3) and resend new
>> version of the series based on  our testing branch.

-- 
-
Sathyanarayan Kuppuswamy
Linux kernel developer


--------------6E5C238BD1F3158DE4949113
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Hi Andy,<br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 11/3/2017 5:13 AM, Andy Shevchenko
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAHp75VffZCTgsbgm3RU-vAL4Xf1A60NtDaFwaLQRp5UqtztfuQ@mail.gmail.com">
      <pre wrap="">I think I already told that this one had been pushed to my review and
testing queue, thanks!</pre>
    </blockquote>
    I thought you specifically asked me to include this patch in next
    set. Following is your previous comment. Patch 3 in your reply
    points to this patch.<br>
    <br>
    <span style="color: rgb(34, 34, 34); font-family: arial, sans-serif;
      font-size: 12.8px; font-style: normal; font-variant-ligatures:
      normal; font-variant-caps: normal; font-weight: 400;
      letter-spacing: normal; orphans: 2; text-align: start;
      text-indent: 0px; text-transform: none; white-space: normal;
      widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px;
      background-color: rgb(255, 255, 255); text-decoration-style:
      initial; text-decoration-color: initial; display: inline
      !important; float: none;">&gt;&gt; I have applied this patch with
      some modifications to my review-andy branch.</span><br
      style="color: rgb(34, 34, 34); font-family: arial, sans-serif;
      font-size: 12.8px; font-style: normal; font-variant-ligatures:
      normal; font-variant-caps: normal; font-weight: 400;
      letter-spacing: normal; orphans: 2; text-align: start;
      text-indent: 0px; text-transform: none; white-space: normal;
      widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px;
      background-color: rgb(255, 255, 255); text-decoration-style:
      initial; text-decoration-color: initial;">
    <span style="color: rgb(34, 34, 34); font-family: arial, sans-serif;
      font-size: 12.8px; font-style: normal; font-variant-ligatures:
      normal; font-variant-caps: normal; font-weight: 400;
      letter-spacing: normal; orphans: 2; text-align: start;
      text-indent: 0px; text-transform: none; white-space: normal;
      widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px;
      background-color: rgb(255, 255, 255); text-decoration-style:
      initial; text-decoration-color: initial; display: inline
      !important; float: none;">&gt;&gt; Please, take it from there (and
      probably patch 3) and resend new</span><br style="color: rgb(34,
      34, 34); font-family: arial, sans-serif; font-size: 12.8px;
      font-style: normal; font-variant-ligatures: normal;
      font-variant-caps: normal; font-weight: 400; letter-spacing:
      normal; orphans: 2; text-align: start; text-indent: 0px;
      text-transform: none; white-space: normal; widows: 2;
      word-spacing: 0px; -webkit-text-stroke-width: 0px;
      background-color: rgb(255, 255, 255); text-decoration-style:
      initial; text-decoration-color: initial;">
    <span style="color: rgb(34, 34, 34); font-family: arial, sans-serif;
      font-size: 12.8px; font-style: normal; font-variant-ligatures:
      normal; font-variant-caps: normal; font-weight: 400;
      letter-spacing: normal; orphans: 2; text-align: start;
      text-indent: 0px; text-transform: none; white-space: normal;
      widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px;
      background-color: rgb(255, 255, 255); text-decoration-style:
      initial; text-decoration-color: initial; display: inline
      !important; float: none;">&gt;&gt; version of the series based on
      our testing branch.</span><br>
    <br>
    <pre class="moz-signature" cols="72">-- 
-
Sathyanarayan Kuppuswamy
Linux kernel developer</pre>
  </body>
</html>

--------------6E5C238BD1F3158DE4949113--
