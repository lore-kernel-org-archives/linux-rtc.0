Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33972 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751814AbdHUKtQ (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 21 Aug 2017 06:49:16 -0400
Received: by mail-wr0-f196.google.com with SMTP id p14so11708863wrg.1
        for <linux-rtc@vger.kernel.org>; Mon, 21 Aug 2017 03:49:15 -0700 (PDT)
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH] rtc: zynqmp: Disable the build as a module
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org,
        =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
        linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        linux-arm-kernel@lists.infradead.org
References: <9881f4ae2afb2cd671715bcd1fcb9035688c40c9.1500464394.git.michal.simek@xilinx.com>
 <20170821084641.p432yvwciwj6irdk@piout.net>
From: Michal Simek <monstr@monstr.eu>
Message-ID: <dd3127ef-8061-c357-8f55-5f661e8eda3a@monstr.eu>
Date: Mon, 21 Aug 2017 12:49:07 +0200
MIME-Version: 1.0
In-Reply-To: <20170821084641.p432yvwciwj6irdk@piout.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="VofX8n1rqDJPwT4dOOVCukB3xiBOICp53"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VofX8n1rqDJPwT4dOOVCukB3xiBOICp53
Content-Type: multipart/mixed; boundary="NRSNKS3L6hnna22hEhtI3HKHmDtJwA543";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, =?UTF-8?Q?S=c3=b6ren_Brinkmann?=
 <soren.brinkmann@xilinx.com>, linux-rtc@vger.kernel.org,
 Alessandro Zummo <a.zummo@towertech.it>, linux-arm-kernel@lists.infradead.org
Message-ID: <dd3127ef-8061-c357-8f55-5f661e8eda3a@monstr.eu>
Subject: Re: [PATCH] rtc: zynqmp: Disable the build as a module
References: <9881f4ae2afb2cd671715bcd1fcb9035688c40c9.1500464394.git.michal.simek@xilinx.com>
 <20170821084641.p432yvwciwj6irdk@piout.net>
In-Reply-To: <20170821084641.p432yvwciwj6irdk@piout.net>

--NRSNKS3L6hnna22hEhtI3HKHmDtJwA543
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 21.8.2017 10:46, Alexandre Belloni wrote:
> Hi,
>=20
> As discussed, I will not apply that patch and instead will push for:
> https://patchwork.kernel.org/patch/9911471/

no problem with this.

M


--NRSNKS3L6hnna22hEhtI3HKHmDtJwA543--

--VofX8n1rqDJPwT4dOOVCukB3xiBOICp53
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlmauqMACgkQykllyylKDCEAIQCfRaJk4QJ5hQDkQgeiOHut7MXz
B2wAn3UV6YORU2Yk/NnqKuYkhMiMteS5
=f3SJ
-----END PGP SIGNATURE-----

--VofX8n1rqDJPwT4dOOVCukB3xiBOICp53--
