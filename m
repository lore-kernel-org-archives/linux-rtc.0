Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795071955;
	b=FIVJ6CXhr64jH1QBd7y1iEo5QXFMeFb7m4waOXAciz4SPGFz76kEvSD5cHtRWWehAHpM
	 rs0Xazv6E78hrMZlIdzlN0ujbNbtU39E/otvr++yl7pIGG84I9h28DfEtoxCIbrPZZ/N9
	 RkYFpcPye4BNTs80DRev8IMtS2/cvLsz6X7fSN/NL6mDbulQ0xOVgBqGItpm/XprBqRxD
	 YmZHn+fmylUc8cVmqOpIUSx8fP3UX9siwjkO/fzL5gtpQyjACz7TS5fznTk+SdKO5UYAo
	 hZ1RvvloPc3QqgD1Uwr6AZWO3AY+oWTi7hYRo6bA6hCPhHpEnBOwX8BOD72Oz8HG9Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795071955;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AaC4QCANi9ljDFQvZAm1AqpQaXclnuK36mF4MTPmkv0=;
	b=kpjo7lSQ00peDcV3jGcetEnHTPSzYGF8Nql9SeGOgnROF89RCREEcffKN7nAeKWmbiUX
	 dh937PGQnelt8ny8zesZ7vXXR36igr+FqDwf5dJmcBYhB4cM6OgNniRbAVWZKO3RVeQFD
	 +wPfDuraoUHbGHoQPWbeI+wpFTqtSdAOb+Y9V+GqQEG2qhZywL6muCf+Ulp452YYhtRw3
	 WmCMDtNVir2oAmtN25vxhkQpqDN0PLHlsxHGmTDWLI2AijI0V3izr7mTSVDCDV+S039Ps
	 FQqZebLo9X7ZeGCvcXV1wLLVQlF2VWnPHcnvzpSv9//BGfwMa5le/0Tx4xYbQAOJAkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a1pcaAJE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070A0606A320
	for <linux-rtc@vger.kernel.org>; Thu, 19 Nov 2026 07:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a1pcaAJE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E731F000C4;
	Thu, 19 Nov 2026 07:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795071954;
	bh=AaC4QCANi9ljDFQvZAm1AqpQaXclnuK36mF4MTPmkv0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a1pcaAJEu5Suyv8buiFIIjNfq7JvN9L45TfSmU/I1V16d2gYU++wEMJERNojjRDAT
	 hUC+dgzsn/U7Hu21LLk6oT1VjXC3vmhC2AmU4LnG2D1Qfqtj9mLUZN8SvdgwSgGaiH
	 uG/IknlQ8KeKLEo77+9T0B1+Vf5Iv7mX5v8O0VjN+XbCtwzVdAJqQVI5nRTqF8djQW
	 v0WC1H5FDtxS9jtdtHGLe8kSdtglBlCQJcm9P7ZxtNxwqUmzc915C5ry/M8mwvcPR9
	 6KGOn88DIHhInQGxQDa2mjVUGchbt7fqiVaHlRizr4eBH1P02tGYUqVUy0qfnV0YMM
	 zVwjaAjPRiyCQ==
Message-ID: <sashiko-outbox-222541@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] soc: qcom: pmic_glink: Add GIO pmic_glink
 instance
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fenglin Wu" <fenglin.wu@oss.qualcomm.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261118-gio-framework-rtc-driver-2026-10-12-v3-2-52d78a8f43ee@oss.qualcomm.com>
References: <20261118-gio-framework-rtc-driver-2026-10-12-v3-0-52d78a8f43ee@oss.qualcomm.com>
 <20261118-gio-framework-rtc-driver-2026-10-12-v3-2-52d78a8f43ee@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 07:05:54 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> Add a PMIC GLINK transport instance for GIO (General I/O) which is a
> new communication model used by the SoCCP battery-management firmware
> on some of the Qualcomm platforms (e.g. Glymur): it turns the
> GIO_OPCODE_BLOCK_READ/_WRITE requests and the GIO_OPCODE_ALERT_IND
> notification exchanged over the pmic-glink rpmsg channel into a regmap
> and per-alert IRQ delivery. It registers as a "pmic_glink.gio"
> auxiliary driver and bound to a new "gio" auxiliary device that's created
> on GIO-capable platforms.
>=20
> Also, update the client_mask to additionally request the GIO client on
> Glymur, which is the 1st platform to support GIO. Even through the legacy
> clients (battmgr, ucsi, altmode) can also be supported using the new GIO
> interface, their per-client bits are still kept with the functionalities
> continue to be provided by the existing pmic_glink.* auxiliary devices
> using the pmic_glink interfaces, to minimize the risks associated with
> transitioning all of them to use the new GIO interface.
>=20
> Co-developed-by: Tingguo Cheng <tingguo.cheng@oss.qualcomm.com>
> Signed-off-by: Tingguo Cheng <tingguo.cheng@oss.qualcomm.com>
> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-gio-framew=
ork-rtc-driver-2026-10-12-v3-0-52d78a8f43ee@oss.qualcomm.com?part=3D2

