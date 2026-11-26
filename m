Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795678243;
	b=COkFi/3cny1+A7zE86x2LX4bo9AZ/PN6LvBqR7VqoYsgDoTXoSrC+7V+3cnO2Vd645R2
	 xc5YT8eNviiRT2JOdHc0SRkaifnvLUhwzKnJoT6pfh5NSLLKtwmKF07TyQV+OF3kF+5dk
	 s2Ab3D3jg1GDXII5Ox0AcQDN/S0FTExbnGlEO17jCK0uTpdNn4hIGFEpzvFBU9C+WcPDV
	 caBE67PXaE5v413Y/a2PqVoS1qxwgGLelTmygoMIEQ3FJ2U2+29jwG47tKWwkBirje00G
	 /7HbxXx2nvRg7stjsjzBjo+LMAtnA7jp2FKRZ9otwywOkti4If6tSM7J82ZQl50IMmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795678243;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TIIUeINvbUXL44ktRwRbmC6y5EWQo3f4y6Mesu+e860=;
	b=R8CrLZrWxXmrjlq6PCCaXcV3cTCUu6DsQmv5+Mh8DCZwjXBj1jpm24N7W/3YDWSH3JOH
	 pGIpklI6q4MIm5wsSY381nmrb4vUjpN66fLLvOVPzAcA7oINKP/wQEt5uuZa5ccRpAjIM
	 6Uctq7zwV/H4Zdc0obIOAU3+nOxXLvWb26XlaglqHv2RNq8RxJfLZsoX7h2BB57vkis+d
	 T9tmK50NxZaBIPz5cab2ayn0EDmB8nigcobL/r37py62AHdgnXkzdhc6XQdyrpCy8b/+D
	 vnnUQzcoUm1TZlUCY1alf6jBnOzAX8No9IKSqdPEmAI6WnP9g1A6ZxH+TCHwbmTlHvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bOr6Tb+5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C875606A31E;
	Thu, 26 Nov 2026 07:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bOr6Tb+5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD041F000D2;
	Thu, 26 Nov 2026 07:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795678243;
	bh=TIIUeINvbUXL44ktRwRbmC6y5EWQo3f4y6Mesu+e860=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bOr6Tb+5zWJRUnDfZZ4APQNCE8JMGAVU0zqSKQn5+3DZGEXw+OOfnuRZGVLFcEC+7
	 OclDdLqmJaQSsYYCjrkwlFTtn4J9vN/tnE4ztyA7C3o+tvLl6TMMmhdMkrJiQ7CEUr
	 RUKbo1Uzbt0oFfKviV96Ue1wA5eiwUtfPMHqhGBcOJxZEnPYjV6TbAt4Sq/59GI7LW
	 O7fPqVWef+pRo/4++7FIuRukiXJ5RaKsb7K+y+fDDeqkeyYaAFnqdZUZp64P1TZJqs
	 AGhKHnBbOAGkrkStee+bhiNJZOFZBxfAOP36eny9GQnWN3pexVhms0aeadoB6OtIya
	 jmLd57u5U0Uqw==
Message-ID: <sashiko-outbox-234958@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 0/4] rtc: Add NXP PCF8525 RTC support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shiv Prakash Gupta" <shivprakash.gupta@nxp.com>, linux-rtc@vger.kernel.org, linux-hwmon@vger.kernel.org
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261126071124.2383368-1-shivprakash.gupta@nxp.com>
References: <20261126071124.2383368-1-shivprakash.gupta@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 07:30:41 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 4-patch series:

- Patches 1 and 4: no issues found.
- Patch 2 ("rtc: pcf8525: Add NXP PCF8525 RTC driver"): 1 potential
  issue (1 Medium)
- Patch 3 ("rtc: pcf8525: Add watchdog support"): 1 potential issue (1
  High)

Detailed reviews have been sent as separate replies to patches 2 and 3.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126071124.2383=
368-1-shivprakash.gupta@nxp.com
