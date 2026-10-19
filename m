Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444962;
	b=JPj48iWJYLd94qW+qgNty3idcoYOy/hSr25FplL3H8NuhwX3yG0Qn9PCH2Y+ys03OJDM
	 752KsXpl1J33ZksUONvZ/liLIU/ukIRV+kDkVcA5Oc2/Lwm55QSu6dQAywD5k0Sd9tm5m
	 3/fu8vUx/K5iqXVSLor0/lPWLluJ8FmvgRPc6QmYriUbjXb6BUHl4plIM8Z+BnnBYGIvt
	 63nc9cQB1qcxSS207xWyXOgZtDiVsxDOFfAIY5gLMr6KVbnmHrC6CJNhQLMlyuPI35VIb
	 xTew/yFN4RP6nde9gs8yfllBiXwRjJKLcJ281dcEZ2GmPHXPzddxPFnloG6w3IRnLYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444962;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pLPAL09AMsvC9vu9j8YsyTj97LLhc48u/6GJoyowlig=;
	b=j80jYCgHxBy9ktTFaextkWadSjtmUdZbtlRfvZhzJpDQ3PVrl+7DjxfplSOz2Z0WY0QC
	 5NqvwXjjC49pun34fYI7L+cM5kiju87BH9p8pJ/jVbx0IkshhQSxEYaGJudUGOOCXkhLS
	 TzvQJB4tINpL9jL4cx+oYCWC2JXi/ZI6M/0ShDhsLToDY0GkUHEJTyKE7t2/rz2EP/xlK
	 HereyqD21DPWuNyBqFWbzXq0fdOrkSY/2TEIWpZTv5Rd+38+DJLWjgG1f7LqcbiP/1ziz
	 BGeJGpN51vfw/BqE/wV+zWxAfsLM4mxX5ReJuQSLH6D4c58FrfRmwpHFVEMHo5qiaow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=crv8zTzC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2099F606A319
	for <linux-rtc@vger.kernel.org>; Mon, 19 Oct 2026 21:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=crv8zTzC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1FB21F000C8;
	Mon, 19 Oct 2026 21:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792444962;
	bh=pLPAL09AMsvC9vu9j8YsyTj97LLhc48u/6GJoyowlig=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=crv8zTzClEYxjOX02trmExw5YlPdWRl9H/fVDCnw7WACJdK9P7k1WuCyhnBYlbdNo
	 Y5Og2itJuWbhwwPwEQmIV1oQfvLu/vN7V6Z02GmcBLup5p6hTCd87Y1wYICwsT8O9i
	 IFQE+lTryZiVviFup9duq1W1MGz7AZgkFOPzV36pfpRwFle8QzK0vXykmZ632YRC1c
	 uS97P/T2hpDOLPVnfJDYYBOBIyLMXJobOuyYKGm/Ricg5nNNgw61lViA+rdzmjRxpT
	 rmH2Qdk5ZT5ow+PbVp3/F7s9GRcT+LH/EYuD9gZyE6dHmA/47hCrPcqrAkyUMMSGRj
	 iZtJZagzujAxA==
Message-ID: <sashiko-outbox-178242@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 17/19] rtc: rx8025: use guard
Reply-To: sashiko-reviews@lists.linux.dev
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org
In-Reply-To: <20261019211827.126262-17-alexandre.belloni@bootlin.com>
References: <20261019211827.126262-1-alexandre.belloni@bootlin.com>
 <20261019211827.126262-17-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 21:22:41 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
>=20
> Use guard() to simplify error handling
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019211827.1262=
62-1-alexandre.belloni@bootlin.com?part=3D17

